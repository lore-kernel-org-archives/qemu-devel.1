Received: from eggs.gnu.org ([209.51.188.92]:58162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggTDq-0003E6-BS
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:37:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ggTDp-0000Nj-LG
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:37:34 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38667)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ggTDp-0000Ms-8D
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:37:33 -0500
Received: by mail-wr1-x442.google.com with SMTP id v13so66023wrw.5
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 03:37:33 -0800 (PST)
References: <20181221195200.6544-1-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181221195200.6544-1-cota@braap.org>
Date: Mon, 07 Jan 2019 11:37:30 +0000
Message-ID: <87muocvgud.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] fp-bench fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org


Emilio G. Cota <cota@braap.org> writes:

> Two small fixes for fp-bench. They fix the fact that we weren't
> generating normals, even though we intended to.
>
> You can pull this series from:
>   https://github.com/cota/qemu/tree/fp-bench-fixes
>
> Thanks,
>
> 		Emilio

Queued to fpu/next, thanks.

--
Alex Benn=C3=A9e
