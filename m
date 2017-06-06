Received: from eggs.gnu.org ([2001:4830:134:3::10]:46521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dICoG-0006Tf-Ca
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:38:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dICoF-0006GJ-JL
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:38:04 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:35902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dICoF-0006G0-CD
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:38:03 -0400
Received: by mail-wm0-x234.google.com with SMTP id 7so95459552wmo.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 04:38:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87tw3tctl1.fsf@linaro.org>
References: <20170602160848.4913-1-alex.bennee@linaro.org>
	<20170602160848.4913-6-alex.bennee@linaro.org>
	<CAFEAcA_g6u+bsmb2JkqmBmy-N14BHFcTJTsvUTO27_q1nmbYgg@mail.gmail.com>
	<87tw3tctl1.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 12:37:40 +0100
Message-ID: <CAFEAcA-eXF1Yct3qnE8AygcDq8oziTHSfKn46tqgU7GGj+OA5A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v4 05/10] risu: paramterise
 send/receive functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 6 June 2017 at 11:13, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>> If you're going to fix the indent can you put that in
>> its own patch, please? Much easier to review that way.
>
> Damn I forgotten that got munged. Can we agree on what the indent should
> be for risu? 3 or 4, space or tabs?

Same as QEMU coding style, please.

thanks
-- PMM
