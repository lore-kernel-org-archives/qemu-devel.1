Received: from eggs.gnu.org ([2001:4830:134:3::10]:38446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coDrl-0003EM-If
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:41:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1coDrk-0008O4-6L
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:41:45 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:36754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1coDrj-0008Ne-VE
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:41:44 -0400
Received: by mail-wm0-x232.google.com with SMTP id n11so94803862wma.1
	for <qemu-devel@nongnu.org>; Wed, 15 Mar 2017 11:41:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489583887-14126-1-git-send-email-armbru@redhat.com>
References: <1489583887-14126-1-git-send-email-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Mar 2017 18:41:21 +0000
Message-ID: <CAFEAcA_--LacVR8Z16gBiKoTvOT3yrq__sqw06UwHXB-zKD46w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] Miscellaneous patches for 2017-03-15
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

On 15 March 2017 at 13:18, Markus Armbruster <armbru@redhat.com> wrote:
> The following changes since commit d84f714eafedd8bb9d4aaec8b76417bef8e3535e:
>
>   Update version for v2.9.0-rc0 release (2017-03-14 19:18:23 +0000)
>
> are available in the git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-misc-2017-03-15
>
> for you to fetch changes up to 4d0e72396b69656f36f484b54ffe64893d793a80:
>
>   coverity-model: model address_space_read/write (2017-03-15 13:59:16 +0100)
>
> ----------------------------------------------------------------
> Miscellaneous patches for 2017-03-15
>
> ----------------------------------------------------------------
> Markus Armbruster (1):
>       tests: Use error_free_or_abort() where appropriate
>
> Paolo Bonzini (1):
>       coverity-model: model address_space_read/write
>
>  scripts/coverity-model.c            | 17 +++++++++++++----
>  tests/test-qemu-opts.c              |  3 +--
>  tests/test-qobject-output-visitor.c |  6 ++----
>  3 files changed, 16 insertions(+), 10 deletions(-)
>
> Markus Armbruster (1):
>   tests: Use error_free_or_abort() where appropriate
>
> Paolo Bonzini (1):
>   coverity-model: model address_space_read/write

Applied, thanks.

-- PMM
