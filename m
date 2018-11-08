Received: from eggs.gnu.org ([2001:4830:134:3::10]:37570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKiv9-0003QL-Es
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gKiv6-0000u8-4D
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:56:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gKiv5-0000tM-Gl
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 06:56:19 -0500
Date: Thu, 8 Nov 2018 12:56:03 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181108125603.4fd10307.cohuck@redhat.com>
In-Reply-To: <20181108111531.30671-4-stefanha@redhat.com>
References: <20181108111531.30671-1-stefanha@redhat.com>
	<20181108111531.30671-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 3/8] MAINTAINERS: use 'https://' instead
 of 'git://' for GitHub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Daniel Berrange <berrange@redhat.com>, eblake@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Jeff Cody <jcody@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Alex =?UTF-8?B?QmVu?= =?UTF-8?B?bsOpZQ==?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>

On Thu,  8 Nov 2018 11:15:26 +0000
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> When you clone the repository without previous commit history, 'git://'
> doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> since the client verifies the server certificate.
>=20
> Reported-by: Jann Horn <jannh@google.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Let's make this a

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 74 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 37 insertions(+), 37 deletions(-)
