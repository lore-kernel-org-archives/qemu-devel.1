Received: from eggs.gnu.org ([209.51.188.92]:44608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hG3or-0001pU-5t
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:46:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hG3oj-00011w-Uj
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:46:48 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:43547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hG3og-0000vZ-1A
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:46:42 -0400
Received: by mail-oi1-x231.google.com with SMTP id t81so14178733oig.10
	for <qemu-devel@nongnu.org>; Mon, 15 Apr 2019 08:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190415141547.15444-1-berrange@redhat.com>
	<CAFEAcA9353Sar3Uny0Qvx0Ex6jP-dzE2w4AjsA4O8gCEF3RdKA@mail.gmail.com>
	<0ade556d-bdf1-4440-472a-1e3e6cb7387a@redhat.com>
In-Reply-To: <0ade556d-bdf1-4440-472a-1e3e6cb7387a@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Apr 2019 16:46:29 +0100
Message-ID: <CAFEAcA-ZYZ2M-nLThqc6bP2ZqeoRUEt_-7qA3m=obTyyi=7zow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] vl: set LC_CTYPE early in main() for
 all code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Bandan Das <bsd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 15 Apr 2019 at 16:25, Eric Blake <eblake@redhat.com> wrote:
> "two known problems" but...
>
> ...three bullet points.

Nobody expects the Spanish Inquisition to be code reviewed :-)

thanks
-- PMM
