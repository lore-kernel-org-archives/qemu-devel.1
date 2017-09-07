Received: from eggs.gnu.org ([2001:4830:134:3::10]:38751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dptN5-0006P4-9V
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:45:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dptMv-0001v5-Qn
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:45:15 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:36460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dptMv-0001uu-Ih
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:45:05 -0400
Received: by mail-wm0-x22c.google.com with SMTP id r10so268127wmf.1
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 02:45:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170906114456.27339-1-quintela@redhat.com>
References: <20170906114456.27339-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Sep 2017 10:44:43 +0100
Message-ID: <CAFEAcA_htx5O8ckjeHHs0BaLcQeU-EtDKxDsXtuoPzYB0iAAXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Fix tests with new gcc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On 6 September 2017 at 12:44, Juan Quintela <quintela@redhat.com> wrote:
> Hi
>
> TNhis has already been reviewed on list.
>
> Please, apply.
>
> The following changes since commit b07d1c2f5607489d4d4a6a65ce36a3e896ac065e:
>
>   Revert "kvm: use DIV_ROUND_UP" (2017-09-05 18:55:40 +0100)
>
> are available in the git repository at:
>
>   git://github.com/juanquintela/qemu.git tags/tests/20170906
>
> for you to fetch changes up to c18aaeb69072b74cb0a66e6638fcb14837c7cd3a:
>
>   tests: Make vmgenid test compile (2017-09-05 22:34:40 +0200)
>
> ----------------------------------------------------------------
> tests/next for 20170906
>
> ----------------------------------------------------------------
> Juan Quintela (2):
>       tests: Use real size for iov tests
>       tests: Make vmgenid test compile

Applied, thanks.

-- PMM
