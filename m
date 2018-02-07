Received: from eggs.gnu.org ([2001:4830:134:3::10]:34788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejPEy-0006AQ-2Y
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:54:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejPEx-0007MN-9Q
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:54:20 -0500
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:43256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejPEx-0007Kp-4N
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 07:54:19 -0500
Received: by mail-oi0-x22f.google.com with SMTP id 4so553453ois.10
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 04:54:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+ukUFKkTnoDXbLDay8Gu9atEEdnzkwa9G3LErKLe_H+Q@mail.gmail.com>
References: <1517858941-5538-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8xGrkYY14hm6htgs3oqB1gaKHFRLktz2x0tOFageDqYQ@mail.gmail.com>
	<4ce6f2ad-2287-2155-277b-977e48167687@redhat.com>
	<CAFEAcA_mAK2jeX9Uu=Mtx4PUOVToXFW351OKgu6B4A0kj_79aw@mail.gmail.com>
	<4c81a8d5-5d88-2f31-13be-4ae12007b2b3@redhat.com>
	<CAJ+F1C+ukUFKkTnoDXbLDay8Gu9atEEdnzkwa9G3LErKLe_H+Q@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Feb 2018 12:53:58 +0000
Message-ID: <CAFEAcA_4gVRyFtW=5_41x3sPwp8Q1aungXgh9uux8A5kVTXSJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/47] Misc patches for 2018-02-05
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 7 February 2018 at 12:49, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
> It is a bit weird that this is not caught during configure time, that
> does check static compilation (when --static) with the sanitizers.
> What is the host? is there a docker check to reproduce?

The host is x86-64 ubuntu xenial.

thanks
-- PMM
