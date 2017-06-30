Received: from eggs.gnu.org ([2001:4830:134:3::10]:47363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQvzD-0001JJ-Cb
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dQvz7-0005Dx-Sq
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:29:27 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:40887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dQvz7-0005C3-Gj
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 09:29:21 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1498749056-38565-3-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1498749056-38565-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1498749056-38565-3-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Fri, 30 Jun 2017 15:29:05 +0200
Message-ID: <w51podld2ou.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v6 2/6] qmp: Create IOThrottle structure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Thu 29 Jun 2017 05:10:52 PM CEST, Pradeep Jagadeesh wrote:
> This patch enables qmp interfaces for the fsdev
> devices. This provides two interfaces one 
> for querying info of all the fsdev devices. The second one
> to set the IO limits for the required fsdev device.
>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
