Received: from eggs.gnu.org ([2001:4830:134:3::10]:55106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTRB0-0002cE-Oi
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fTRAz-0006Oc-Uz
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:16:30 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:44715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fTRAz-0006OL-PI
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 08:16:29 -0400
Received: by mail-oi0-x241.google.com with SMTP id c128-v6so5419122oig.11
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 05:16:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180613131045.17379-1-armbru@redhat.com>
References: <20180613131045.17379-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Jun 2018 13:16:08 +0100
Message-ID: <CAFEAcA-i7_h=7k=41YQdUMMPezTk4dP9wLvuGsbtqg1U-wT1Kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/3] Miscellaneous patches for 2018-06-13
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 June 2018 at 14:10, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit 2ab09bf2f9f55b9fb8d2de6eb2ba2a8570e268e2:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20180612-pull-request' into staging (2018-06-12 15:34:34 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2018-06-13
>
> for you to fetch changes up to 719a30776b94d3da8c613e5047414f483d40256d:
>
>   Purge uses of banned g_assert_FOO() (2018-06-13 13:47:35 +0200)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2018-06-13
>
> ----------------------------------------------------------------
> Markus Armbruster (2):
>       Revert "Makefile: add target to print generated files"
>       Purge uses of banned g_assert_FOO()
>
> Paolo Bonzini (1):
>       coverity-model: replay data is considered trusted
>

Applied, thanks.

-- PMM
