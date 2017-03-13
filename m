Received: from eggs.gnu.org ([2001:4830:134:3::10]:39036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnRaL-0008Ch-4O
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:08:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cnRaK-0008Iw-6Y
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:08:33 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:36388)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cnRaJ-0008Io-Vr
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 11:08:32 -0400
Received: by mail-wm0-x230.google.com with SMTP id n11so42741057wma.1
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 08:08:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170310184552.1481-1-ehabkost@redhat.com>
References: <20170310184552.1481-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Mar 2017 16:08:10 +0100
Message-ID: <CAFEAcA8ptuWRR4S7-A3c-qCwa=LJrbYLDGZ3ZVpa3J0jzxGvYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/3] x86: Haswell TSX blacklist fix for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>

On 10 March 2017 at 19:45, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The following changes since commit dd4d2578215cd380f40a38028a9904e15b135ef3:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-fixes-20170309-1' into staging (2017-03-09 13:16:05 +0000)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-pull-request
>
> for you to fetch changes up to ec56a4a7b07e2943f49da273a31e3195083b1f2e:
>
>   i386: Change stepping of Haswell to non-blacklisted value (2017-03-10 15:01:09 -0300)
>
> ----------------------------------------------------------------
> x86: Haswell TSX blacklist fix for 2.9
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
