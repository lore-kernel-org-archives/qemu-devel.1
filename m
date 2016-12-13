Received: from eggs.gnu.org ([2001:4830:134:3::10]:45652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGlhI-000182-Kg
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:56:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGlhE-0003Qo-5I
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:56:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cGlhE-0003Qh-0U
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 06:56:36 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1480432054-12065-1-git-send-email-yuval.shaia@oracle.com>
Date: Tue, 13 Dec 2016 12:56:32 +0100
In-Reply-To: <1480432054-12065-1-git-send-email-yuval.shaia@oracle.com> (Yuval
	Shaia's message of "Tue, 29 Nov 2016 17:07:34 +0200")
Message-ID: <8737hsoxe7.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2] slirp,
 disas: Replace min/max with MIN/MAX macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: laurent@vivier.eu, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, qemu-devel@nongnu.org

Yuval Shaia <yuval.shaia@oracle.com> writes:

> Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
