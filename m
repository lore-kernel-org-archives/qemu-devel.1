Received: from eggs.gnu.org ([2001:4830:134:3::10]:33564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fq0dS-00045C-4t
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 14:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fq0dP-0005wo-Ji
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 14:35:08 -0400
Received: from mail-oi0-x22a.google.com ([2607:f8b0:4003:c06::22a]:45542)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fpxmu-0001yJ-70
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 11:32:45 -0400
Received: by mail-oi0-x22a.google.com with SMTP id q11-v6so2571573oic.12
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 08:32:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180815031248.14908-1-famz@redhat.com>
References: <20180815031248.14908-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Aug 2018 16:31:56 +0100
Message-ID: <CAFEAcA_02nvU+ZL6jZf-hcmbC2t5n4Jf-V7jUjCuV+aLguTpPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] Block and testing patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 August 2018 at 04:12, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 38441756b70eec5807b5f60dad11a93a91199866:
>
>   Update version for v3.0.0 release (2018-08-14 16:38:43 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/famz/qemu.git tags/block-and-testing-pull-request
>
> for you to fetch changes up to 37a81812f7b8367422a039eb09d915df543983ee:
>
>   aio-posix: Improve comment around marking node deleted (2018-08-15 10:12:35 +0800)
>
> ----------------------------------------------------------------
> Block and testing patches for 3.1
>
> - aio fixes by me
> - nvme fixes by Paolo and me
> - test improvements by Peter, Phil and me
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
