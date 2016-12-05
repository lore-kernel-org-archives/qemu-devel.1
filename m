Received: from eggs.gnu.org ([2001:4830:134:3::10]:60737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cDvcI-0002MA-4b
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:55:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cDvcH-0004Qa-D3
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:55:46 -0500
Received: from mail-vk0-x232.google.com ([2607:f8b0:400c:c05::232]:34163)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cDvcG-0004PA-Tm
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 10:55:45 -0500
Received: by mail-vk0-x232.google.com with SMTP id x186so180799687vkd.1
	for <qemu-devel@nongnu.org>; Mon, 05 Dec 2016 07:55:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b6c3b949-ef2a-31f4-ce86-712ce7b64a3f@twiddle.net>
References: <20161202173454.19179-1-alex.bennee@linaro.org>
	<8737i21vl8.fsf@linaro.org>
	<b6c3b949-ef2a-31f4-ce86-712ce7b64a3f@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Dec 2016 15:55:23 +0000
Message-ID: <CAFEAcA9k6u41vMcemdoFZ-imH6e6YAsoSMNMgr3km+G544s=uA@mail.gmail.com>
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>, "open list:ARM" <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 5 December 2016 at 15:42, Richard Henderson <rth@twiddle.net> wrote:
> We'll have to fix it properly eventually.  But perhaps 2.9 is soon enough,
> since that's when mttcg will go in.

Could you provide a reviewed-by (or an explicit nak) for Alex's
patch, please? I didn't look at this area of the code when it
went in so I'm not really in position to review it even if it
goes via my tree.

thanks
-- PMM
