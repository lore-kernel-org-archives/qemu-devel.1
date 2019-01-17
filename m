Received: from eggs.gnu.org ([209.51.188.92]:52854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gk8nZ-0000VC-CK
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:37:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gk8nY-0000PB-KA
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:37:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gk8nY-0000Jt-A6
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 09:37:36 -0500
References: <20190117090259.32713-1-sgarzare@redhat.com>
	<20190117090259.32713-6-sgarzare@redhat.com>
	<0bbdcb55-27d9-7098-10f4-aa7aef0a1c24@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aa7f4f9e-90b2-c53c-9ddb-b27fd2977d2d@redhat.com>
Date: Thu, 17 Jan 2019 15:37:24 +0100
MIME-Version: 1.0
In-Reply-To: <0bbdcb55-27d9-7098-10f4-aa7aef0a1c24@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 5/5] optionrom/pvh: load initrd from
 fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>, Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Richard Henderson <rth@twiddle.net>, George Kennedy <george.kennedy@oracle.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>

On 17/01/19 15:33, Liam Merwick wrote:
> #=C2=A0=C2=A0=C2=A0 pc-bios/optionrom/pvh.bin
> #=C2=A0=C2=A0=C2=A0 pc-bios/optionrom/pvh.img
> #=C2=A0=C2=A0=C2=A0 pc-bios/optionrom/pvh.raw

pvh.bin should not be ignored.

Paolo
