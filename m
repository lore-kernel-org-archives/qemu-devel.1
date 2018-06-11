Received: from eggs.gnu.org ([2001:4830:134:3::10]:43486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSPsH-0003Sx-6G
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:40:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fSPsG-00089W-KQ
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:40:57 -0400
Received: from mail-oi0-x232.google.com ([2607:f8b0:4003:c06::232]:39949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fSPsG-00088n-FO
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 12:40:56 -0400
Received: by mail-oi0-x232.google.com with SMTP id f79-v6so18467703oib.7
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 09:40:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180611101551.2f656715@w520.home>
References: <20180611141716.3813-1-peter.maydell@linaro.org>
	<20180611101551.2f656715@w520.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Jun 2018 17:40:35 +0100
Message-ID: <CAFEAcA_Y5zkoiSyHfuvnhSUPOc44fpGj7j373Rz2+Gf0yGF6sQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] CODING_STYLE: Define our preferred form
 for multiline comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Richard Henderson <rth@twiddle.net>, John Snow <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On 11 June 2018 at 17:15, Alex Williamson <alex.williamson@redhat.com> wrote:
> Much preferred, thanks  (tabs next? ;)

CODING_STYLE already mandates spaces-only, no-tabs...

thanks
-- PMM
