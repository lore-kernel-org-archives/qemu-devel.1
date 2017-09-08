Received: from eggs.gnu.org ([2001:4830:134:3::10]:34876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqFiu-0006gW-Ae
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:37:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqFip-0001To-EZ
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:37:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dqFip-0001TQ-8d
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 05:37:11 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-3-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Fri, 08 Sep 2017 11:37:08 +0200
In-Reply-To: <1504541267-36954-3-git-send-email-pradeep.jagadeesh@huawei.com>
	(Pradeep Jagadeesh's message of "Mon, 4 Sep 2017 12:07:43 -0400")
Message-ID: <87mv65fs57.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 2/6] qmp: Create IOThrottle structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, jani kokkonen <jani.kokkonen@huawei.com>, alberto garcia <berto@igalia.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

Pradeep Jagadeesh <pradeepkiruvale@gmail.com> writes:

> This patch enables qmp interfaces for the fsdev
> devices. This provides two interfaces one
> for querying info of all the fsdev devices. The second one
> to set the IO limits for the required fsdev device.

Recommend to consistently wrap commit message lines around colum 70.

> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
