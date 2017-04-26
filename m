Received: from eggs.gnu.org ([2001:4830:134:3::10]:50907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3LhF-000685-Go
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d3LhE-0000YU-DV
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:05:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d3LhE-0000YO-6w
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 08:05:24 -0400
Date: Wed, 26 Apr 2017 13:05:17 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170426120517.GM18933@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1492845627-4384-1-git-send-email-longpeng2@huawei.com>
	<1492845627-4384-8-git-send-email-longpeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1492845627-4384-8-git-send-email-longpeng2@huawei.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/18] crypto: hmac: move crypto/hmac.h
 into include/crypto/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng(Mike)" <longpeng2@huawei.com>
Cc: arei.gonglei@huawei.com, longpeng.mike@gmail.com, qemu-devel@nongnu.org, weidong.huang@huawei.com

On Sat, Apr 22, 2017 at 03:20:16PM +0800, Longpeng(Mike) wrote:
> Moves crypto/hmac.h into include/crypto/, likes cipher.h and hash.h
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Gonglei <arei.gonglei@huawei.com>
> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> ---
>  crypto/hmac.h         | 166 ------------------------------------------=
--------
>  include/crypto/hmac.h | 166 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  2 files changed, 166 insertions(+), 166 deletions(-)
>  delete mode 100644 crypto/hmac.h
>  create mode 100644 include/crypto/hmac.h

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
