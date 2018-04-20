Received: from eggs.gnu.org ([2001:4830:134:3::10]:40195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9Yiu-0001Zl-Sw
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:17:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f9Yir-0003Ds-N7
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:17:20 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:41251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f9Yir-0003D4-Gf
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 12:17:17 -0400
Received: by mail-wr0-x22c.google.com with SMTP id v24-v6so24387477wra.8
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 09:17:17 -0700 (PDT)
References: <1522980788-1252-1-git-send-email-cota@braap.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1522980788-1252-1-git-send-email-cota@braap.org>
Date: Fri, 20 Apr 2018 17:17:15 +0100
Message-ID: <87in8lam44.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 00/17] tcg: tb_lock_removal redux v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>


Emilio G. Cota <cota@braap.org> writes:

> v1: http://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06499.html
>
> Changes since v1:
>
<snip>

I was just catching up on reviews but there are a fair few conflicts in
the later patches. I also note you have some comments from Richard to
address. Should I wait until v3?

--
Alex Benn=C3=A9e
