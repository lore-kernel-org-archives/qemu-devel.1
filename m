Received: from eggs.gnu.org ([2001:4830:134:3::10]:52000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cbUku-0005xt-7I
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cbUkr-0005Uu-2C
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:06:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cbUkq-0005Uq-TX
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 11:06:01 -0500
References: <20170207155956.21573-1-pbonzini@redhat.com>
	<20170208102949.GD3129@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c3a5fcfa-9736-a294-0aab-cd8214c9e6af@redhat.com>
Date: Wed, 8 Feb 2017 17:05:57 +0100
MIME-Version: 1.0
In-Reply-To: <20170208102949.GD3129@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] link to .xz files to save some bandwidth
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com



On 08/02/2017 11:29, Daniel P. Berrange wrote:
>=20
> Saving GB's of bandwidth a day for our hosting site is a compelling
> benefit, if that has direct impact on project running costs.

It doesn't but only because we're well within what the host is willing
to donate to QEMU.

Paolo

> Shorter
> download times are nice, if you have a very slow internet link too,
> but for most people they'll again be lost in the noise.=20
