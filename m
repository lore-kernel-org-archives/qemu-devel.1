Received: from eggs.gnu.org ([2001:4830:134:3::10]:34689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZZiq-0007F4-6l
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 06:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZZip-0000Ck-DD
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 06:36:48 -0400
Received: from mail-ot0-x235.google.com ([2607:f8b0:4003:c0f::235]:38913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZZip-0000Bx-8P
	for qemu-devel@nongnu.org; Sun, 01 Jul 2018 06:36:47 -0400
Received: by mail-ot0-x235.google.com with SMTP id l15-v6so14452704oth.6
	for <qemu-devel@nongnu.org>; Sun, 01 Jul 2018 03:36:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180630212109.5562-1-jcmvbkbc@gmail.com>
References: <20180630212109.5562-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 1 Jul 2018 11:36:26 +0100
Message-ID: <CAFEAcA-ZngJunCQuyidx4F7vWGHrQgi5UkZWFLFqLL42q3JZ1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] target/xtensa updates
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

On 30 June 2018 at 22:21, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following batch of updates for the target/xtensa.
>
> The following changes since commit e3800998e66c13b24d8cc8a06fdcc8d03cd408fc:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2018-06-30' into staging (2018-06-30 17:30:09 +0100)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20180630-xtensa
>
> for you to fetch changes up to 0f02251a30ea8c4ce64d9a240795e10bb3c5852c:
>
>   xtensa: Avoid calling get_page_addr_code() from helper function (2018-06-30 12:00:17 -0700)
>
> ----------------------------------------------------------------
> target/xtensa updates:
>
> - add diagnostic for zero-overhead loop alignment;
> - convert to TranslatorOps;
> - don't call get_page_addr_code() from helper functions.
>
> ----------------------------------------------------------------
Applied, thanks.

-- PMM
