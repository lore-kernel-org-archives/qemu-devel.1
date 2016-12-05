Received: from eggs.gnu.org ([2001:4830:134:3::10]:40056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cDxYz-0005wU-EM
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cDxYy-0001zy-T9
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:00:29 -0500
Received: from mail-vk0-x22d.google.com ([2607:f8b0:400c:c05::22d]:34502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cDxYy-0001zg-FR
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 13:00:28 -0500
Received: by mail-vk0-x22d.google.com with SMTP id x186so182947908vkd.1
	for <qemu-devel@nongnu.org>; Mon, 05 Dec 2016 10:00:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0bde5bb4-091e-e250-b283-5f1faf8e4351@twiddle.net>
References: <20161202173454.19179-1-alex.bennee@linaro.org>
	<8737i21vl8.fsf@linaro.org>
	<0bde5bb4-091e-e250-b283-5f1faf8e4351@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Dec 2016 18:00:07 +0000
Message-ID: <CAFEAcA-Hx1kWZr1Li2=qdULMBdYyA9pa3cZ=hKPM9d-AqVvv4g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH for-2.8] target-arm/translate-a64: fix
 gen_load_exclusive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 5 December 2016 at 17:22, Richard Henderson <rth@twiddle.net> wrote:
> Acked-by: Richard Henderson <rth@twiddle.net>

Thanks. I've put this into a one-patch pullrequest which I've just
sent out and which will hopefully make -rc3.

thanks
-- PMM
