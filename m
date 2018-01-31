Received: from eggs.gnu.org ([2001:4830:134:3::10]:36022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1egncU-0001wa-Cm
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:19:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1egncR-0003KE-7P
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:19:50 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40797)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christian.ehrhardt@canonical.com>)
	id 1egncQ-0003HD-Vs
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 03:19:47 -0500
Received: from mail-yw0-f198.google.com ([209.85.161.198])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <christian.ehrhardt@canonical.com>)
	id 1egncO-0004CO-Mv
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:19:44 +0000
Received: by mail-yw0-f198.google.com with SMTP id y197so12247154ywg.15
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 00:19:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9qyg-J5UcGZu5XJyUnn799-V4HXSGfyCYNYE9_eK-a0Q@mail.gmail.com>
References: <CAFEAcA9qyg-J5UcGZu5XJyUnn799-V4HXSGfyCYNYE9_eK-a0Q@mail.gmail.com>
From: Christian Ehrhardt <christian.ehrhardt@canonical.com>
Date: Wed, 31 Jan 2018 09:19:13 +0100
Message-ID: <CAATJJ0+f0hzN_EGqs=z=pBAMY1KmsQH0wLBnQ-A55-qYj_P_tQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] proposed release schedule for QEMU 2.12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Tue, Jan 30, 2018 at 5:25 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> It seems like it's about time we settled on the dates for the
> 2.12 release. I've sketched in a suggestion at:
>   https://wiki.qemu.org/Planning/2.12
>
> which puts softfreeze on the 13th March, hardfreeze a
> week later on the 20th, and final release on the 17th April.

Hi Peter,
2.12 looks good to me FWIW, but I wanted to ask if there are
discussions on a 2.11.1 timing as well?
Especially in regard to [1] at least agreeing and defining a date
would be great IMHO.
I haven't seen any date-talk on 2.11.1 and doesn't say anything about it yet.

We touched the topic on some architectures contributions to [1] fixes,
but nobody mentioned a date so far.

[1]: https://www.qemu.org/2018/01/04/spectre/
[2]: https://wiki.qemu.org/Planning/2.11
