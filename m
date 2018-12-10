Received: from eggs.gnu.org ([2001:4830:134:3::10]:55760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWTfz-0006eJ-HL
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gWTfx-0004Hy-Kc
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:05:19 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45962)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gWTfv-0003yA-Rh
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 17:05:16 -0500
Received: by mail-ot1-x343.google.com with SMTP id 32so11985338ota.12
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 14:05:12 -0800 (PST)
MIME-Version: 1.0
References: <20181210183836.20074-1-qwandor@google.com>
	<CAFEAcA9kXXeRkFamN73XREDp4QaokMs3E9TRLThKf4zYufapSQ@mail.gmail.com>
	<CAMKQLNK2J=JsgEch3G-pQ0mjW5B-n8Xc_4PDGHjFs6CfcA2ngg@mail.gmail.com>
In-Reply-To: <CAMKQLNK2J=JsgEch3G-pQ0mjW5B-n8Xc_4PDGHjFs6CfcA2ngg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Dec 2018 22:04:59 +0000
Message-ID: <CAFEAcA9LNUWrW1dePcKh4LLnN9xUKWswWnfjiNN_2JWExCj90A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: Implement VI/VF bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wedsonaf@google.com
Cc: qwandor@google.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 10 Dec 2018 at 21:32, Wedson Almeida Filho <wedsonaf@google.com> wrote:
>
> Hi Peter,
>
> We put this together months ago and hadn't kept up to date with the changes here.
>
> We're happy to see that support has been added for the VI bit. Is it going to be available in the v3.1.0 release?

Yes, that commit is in 3.1.0 -- do test it and let me know if
there's still an issue in this area for your guest code.

thanks
-- PMM
