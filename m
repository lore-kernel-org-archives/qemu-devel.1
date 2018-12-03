Received: from eggs.gnu.org ([2001:4830:134:3::10]:42115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTnGV-0000Bu-Ri
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gTnGS-0006Fc-JV
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:23:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gTnGS-0006FE-E5
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 07:23:52 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181203092617.24090-1-d.csapak@proxmox.com>
	<20181203092617.24090-2-d.csapak@proxmox.com>
Date: Mon, 03 Dec 2018 13:23:49 +0100
In-Reply-To: <20181203092617.24090-2-d.csapak@proxmox.com> (Dominik Csapak's
	message of "Mon, 3 Dec 2018 10:26:15 +0100")
Message-ID: <87d0qi4x4a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 1/3] qapi: Turn ShutdownCause into QAPI
 enum
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dominik Csapak <d.csapak@proxmox.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, pbonzini@redhat.com, mreitz@redhat.com

Dominik Csapak <d.csapak@proxmox.com> writes:

> Needed so the patch after next can add ShutdownCause to QMP events
> SHUTDOWN and RESET.
>
> Signed-off-by: Dominik Csapak <d.csapak@proxmox.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>
