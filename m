Received: from eggs.gnu.org ([2001:4830:134:3::10]:52453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftE5M-0006Fr-GP
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftE5L-0000zo-Lz
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:33:16 -0400
Received: from mail-oi0-x22d.google.com ([2607:f8b0:4003:c06::22d]:45428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftE5L-0000zP-GT
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 11:33:15 -0400
Received: by mail-oi0-x22d.google.com with SMTP id t68-v6so4781665oie.12
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 08:33:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180824073256.19626-1-kraxel@redhat.com>
References: <20180824073256.19626-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 16:32:54 +0100
Message-ID: <CAFEAcA-ZtP8CUSJAE5quaE9Sr=EY9BJcoGqQRH_3EgMXi7y6ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Ui2 20180824 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 24 August 2018 at 08:32, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit 5ccac548faf041ff5229a8e8342e3be14a34c8=
af:
>
>   Merge remote-tracking branch 'remotes/cody/tags/block-pull-request' int=
o staging (2018-08-23 17:35:48 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui2-20180824-pull-request
>
> for you to fetch changes up to eb01505ea6c8330273d189acc053cc60d00bfa1a:
>
>   ui: remove support for SDL1.2 in favour of SDL2 (2018-08-24 09:31:39 +0=
200)
>
> ----------------------------------------------------------------
> ui: remove deprecated UI frontends
>
> ----------------------------------------------------------------
>
> Daniel P. Berrang=C3=A9 (3):
>   ui: remove support for GTK2 in favour of GTK3
>   ui: increase min required GTK3 version to 3.14.0
>   ui: remove support for SDL1.2 in favour of SDL2

Doesn't the last one of these depend on our fixing the
OpenBSD VM first ?

thanks
-- PMM
