Received: from eggs.gnu.org ([2001:4830:134:3::10]:47406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTMgf-0001yo-PO
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dTMgb-0001RB-Pt
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:24:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dTMgb-0001Qv-Ju
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 02:24:17 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<87podcrcxu.fsf@dusky.pond.sub.org>
Date: Fri, 07 Jul 2017 08:24:12 +0200
In-Reply-To: <87podcrcxu.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 07 Jul 2017 08:14:21 +0200")
Message-ID: <87a84gpxwz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v7 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, alberto garcia <berto@igalia.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, jani kokkonen <jani.kokkonen@huawei.com>

PS: Sorry for the late review, got a bit overwhelmed...
