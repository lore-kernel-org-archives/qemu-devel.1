Received: from eggs.gnu.org ([2001:4830:134:3::10]:47731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWRm7-0007NJ-J3
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:54:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cWRm6-0001k6-UG
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:54:27 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:33350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cWRm6-0001jx-Oy
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 12:54:26 -0500
Received: by mail-ua0-x234.google.com with SMTP id i68so164341818uad.0
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 09:54:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485304662-8202-1-git-send-email-jcmvbkbc@gmail.com>
References: <1485304662-8202-1-git-send-email-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Jan 2017 17:54:03 +0000
Message-ID: <CAFEAcA-t0KrLFcL-JBvCn-OpeXZiDH8ptD58rbMiqVGY1RmUvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/14] target/xtensa updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 January 2017 at 00:37, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following batch of updates for target/xtensa.
>
> The following changes since commit a470b33259bf82ef2336bfcd5d07640562d3f63b:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2016-12-22 19:23:51 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20170124-xtensa
>
> for you to fetch changes up to 3a3c9dc4ca2eaa612cbd5d4c85d674b15eadfb02:
>
>   target-xtensa: implement RER/WER instructions (2017-01-16 19:19:03 -0800)
>
> ----------------------------------------------------------------
> target/xtensa updates:
>
> - refactor CCOUNT/CCOMPARE (use QEMU timers instead of instruction counting);
> - support icount; run target/xtensa TCG tests with icount;
> - implement SMP prerequisites: static vector selection, RUNSTALL and RER/WER.
>

Applied, thanks.

-- PMM
