Received: from eggs.gnu.org ([2001:4830:134:3::10]:33769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0qTI-00014V-Sx
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0qTI-0005ro-5x
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:25:12 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:38065)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f0qTI-0005rF-0g
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 11:25:12 -0400
Received: by mail-oi0-x235.google.com with SMTP id c3-v6so19530312oib.5
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 08:25:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180326214409.15326-1-jcmvbkbc@gmail.com>
References: <20180326214409.15326-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Mar 2018 16:24:50 +0100
Message-ID: <CAFEAcA8Y1Ck8yxOoOStYK49Pu0pTPZRiM1qBSGkV=-3RNK6MaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] target/xtensa fixes for 2.12
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

On 26 March 2018 at 22:44, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following fixes for target/xtensa for 2.12:
>
> The following changes since commit 7b93d78a04aa242d377ae213b79db6c319c71847:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-03-26 15:17:25 +0100)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20180326-xtensa
>
> for you to fetch changes up to d0ce7e9cfc8eda113f872b608fe4a3dd7662997e:
>
>   target/xtensa: fix timers test (2018-03-26 14:17:04 -0700)
>
> ----------------------------------------------------------------
> target/xtensa fixes for 2.12:
>
> - add .inc. to non-top level source file names under target/xtensa;
> - fix #include <xtensa-isa.h> in the import_core.sh script;
> - remove stray linux-user/xtensa/syscall.h;
> - fix timers test.

Applied, thanks.

-- PMM
