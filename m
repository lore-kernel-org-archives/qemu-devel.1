Received: from eggs.gnu.org ([2001:4830:134:3::10]:37322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK6Ys-0005h2-Sm
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:58:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK6Yn-0000W0-Nb
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:58:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gK6Yn-0000JK-AS
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:58:45 -0500
References: <1541019806-17696-1-git-send-email-george.kennedy@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a02c97ee-964b-45da-e585-ed1d190ed591@redhat.com>
Date: Tue, 6 Nov 2018 19:58:33 +0100
MIME-Version: 1.0
In-Reply-To: <1541019806-17696-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4] lsi_scsi: Reselection needed to remove
 pending commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: George Kennedy <george.kennedy@oracle.com>, famz@redhat.com, qemu-devel@nongnu.org, boris.ostrovsky@oracle.com

On 31/10/2018 22:03, George Kennedy wrote:
> +#define SCRIPTS_LOAD_AND_STORE  0xe2340004

I'm very confused.  Why did this constant reappear?

Paolo
