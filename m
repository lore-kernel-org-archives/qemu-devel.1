Received: from eggs.gnu.org ([2001:4830:134:3::10]:37281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYVva-0006Tg-SX
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:21:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYVvW-0002ms-OR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:21:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35220 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYVvW-0002lv-Jx
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 08:21:30 -0400
References: <20180628120821.10967-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aeba92d8-8c8f-6d14-e12d-051ba2b2cfbe@redhat.com>
Date: Thu, 28 Jun 2018 07:21:29 -0500
MIME-Version: 1.0
In-Reply-To: <20180628120821.10967-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 0/2] Qio next patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On 06/28/2018 07:08 AM, Daniel P. Berrang=C3=A9 wrote:
> The following changes since commit 00928a421d47f49691cace1207481b7aad31=
b1f1:
>=20
>    Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-=
20180626' into staging (2018-06-26 18:23:49 +0100)
>=20
> are available in the Git repository at:
>=20
>    https://github.com/berrange/qemu tags/qio-next-pull-request
>=20
> for you to fetch changes up to 10aef3e986b4ae3fd909308bdd41c4e7ee1d1d04=
:
>=20
>    Delete AF_UNIX socket after close (2018-06-28 13:06:44 +0100)
>=20
> ----------------------------------------------------------------
> Merge qio 2018-06-28 v2
>=20
> Misc bug fixes for sockets channels
>=20
> ----------------------------------------------------------------
>=20
> Pavel Balaev (1):
>    Delete AF_UNIX socket after close
>=20
> linzhecheng (1):
>    socket: dont't free msgfds if error equals EAGAIN

Our mails crossed. Do you want a v3 that fixes the typo in the subject=20
line of 1/2?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
