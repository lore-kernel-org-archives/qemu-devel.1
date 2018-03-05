Received: from eggs.gnu.org ([2001:4830:134:3::10]:44168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1essGN-0008W4-L7
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:42:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1essGM-0007BP-VU
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:42:55 -0500
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:41693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1essGM-0007BA-PR
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 10:42:54 -0500
Received: by mail-oi0-x242.google.com with SMTP id g5so12339914oiy.8
	for <qemu-devel@nongnu.org>; Mon, 05 Mar 2018 07:42:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180303143823.27055-1-richard.henderson@linaro.org>
References: <20180303143823.27055-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Mar 2018 15:42:33 +0000
Message-ID: <CAFEAcA_8ApwsKgMVSgUfhXZychQGWxRUZfj1f__cppGK5un8fA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 0/5] target/arm linux-user changes for
 sve
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 3 March 2018 at 14:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Changes since v3:
>   * Review comments applied.
>   * Frame allocation generalized in patch 5; hopefully this
>     eliminates some of the confusion seen during review.
>
> Changes since v2:
>   * 5 patches merged,
>   * The PR_SVE_SET/GET_VL patch is more specifically user-only.
>   * Split the signal frame patch into 4 parts.
>



Applied to target-arm.next, thanks.

-- PMM
