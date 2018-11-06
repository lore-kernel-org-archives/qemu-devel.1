Received: from eggs.gnu.org ([2001:4830:134:3::10]:34985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK6Ux-0001vI-PT
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gK6Uw-0004jY-9X
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:54:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gK6Ut-0004ZU-Ff
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 13:54:43 -0500
References: <20181029173437.32559-1-pbonzini@redhat.com>
	<fa37541c-a2a8-8bbc-6114-e15b650da020@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0eb17372-e87f-0875-fac0-7cc26235b6d9@redhat.com>
Date: Tue, 6 Nov 2018 19:54:39 +0100
MIME-Version: 1.0
In-Reply-To: <fa37541c-a2a8-8bbc-6114-e15b650da020@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/4] scsi-generic: fixes for Block Limits
 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: mreitz@redhat.com

On 06/11/2018 16:54, Daniel Henrique Barboza wrote:
> Hi,
>=20
> How did you find all those issues, Max? First patch is something that
> I missed out from the SCSI spec (ordering of the VPD pages)
> and could have been detected by code inspection,=C2=A0 but I am curious=
 about
> the other fixes.

It was found just by code inspection.

Paolo
