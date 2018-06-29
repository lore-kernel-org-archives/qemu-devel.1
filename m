Received: from eggs.gnu.org ([2001:4830:134:3::10]:43146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrnS-0005ee-Tc
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:42:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fYrnP-00035i-7x
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:42:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47254 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fYrnP-00034o-1p
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 07:42:35 -0400
Date: Fri, 29 Jun 2018 12:42:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180629114229.GI27016@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180625111935.26108-1-alex.bennee@linaro.org>
	<20180625111935.26108-3-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180625111935.26108-3-alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 02/10] travis: test out-of-tree builds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: cota@braap.org, famz@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org

On Mon, Jun 25, 2018 at 12:19:27PM +0100, Alex Benn=C3=A9e wrote:
> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> Force one config to build 'out-of-tree' (object files and executables
> are created in a tree outside the project source code).
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .travis.yml | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
