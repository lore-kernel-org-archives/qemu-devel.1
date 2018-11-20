Received: from eggs.gnu.org ([2001:4830:134:3::10]:49666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOuVq-0004AM-Qc
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1gOuVn-0000xH-Ok
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:07:34 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:58662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1gOuVn-0000vt-JL
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 20:07:31 -0500
Date: Tue, 20 Nov 2018 02:07:29 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20181120010729.sanppxyfzriiyjhd@function>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114133229.GL19298@redhat.com>
	<363dbe0f-e342-708f-16ed-ee78bc9d6c5d@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 24/41] slirp: replace
 HOST_WORDS_BIGENDIAN with glib equivalent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, rjones@redhat.com, stefanha@redhat.com, renzo@cs.unibo.it

Philippe Mathieu-Daud=C3=A9, le mer. 14 nov. 2018 14:14:16 +0100, a ecrit=
:
> On 14/11/18 13:36, Marc-Andr=C3=A9 Lureau wrote:
> > One more step towards making the project independent from QEMU.
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Daniel P. Berrang=C3=A9, le mer. 14 nov. 2018 13:32:29 +0000, a ecrit:
>  Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Applied to my tree, thanks!

Samuel
