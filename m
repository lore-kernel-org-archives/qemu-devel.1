Received: from eggs.gnu.org ([2001:4830:134:3::10]:41690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7GHN-000588-AV
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:43:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7GHL-0005BC-4C
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:43:39 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:37958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7GHK-0005Am-OE
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 04:43:39 -0400
Received: by mail-oi1-x22b.google.com with SMTP id u197-v6so873805oif.5
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 01:43:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181001181858.21086-1-jcmvbkbc@gmail.com>
References: <20181001181858.21086-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 09:43:17 +0100
Message-ID: <CAFEAcA_QODE_bnGyxau3AXTe-qh9FmZc6-s5-wrq_V0u1_mhjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/15] target/xtensa: preparation for FLIX
 support
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

On 1 October 2018 at 19:18, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following series that rearranges target/xtensa code in
> preparation for FLIX support.
> The following changes since commit c5e4e49258e9b89cb34c085a419dd9f862935c48:
>
>   Merge remote-tracking branch 'remotes/xanclic/tags/pull-block-2018-09-25' into staging (2018-09-25 16:47:35 +0100)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20181001-xtensa
>
> for you to fetch changes up to d74624e59a6087ccf233843b936aedc9f8a8050a:
>
>   target/xtensa: extract gen_check_interrupts call (2018-10-01 11:08:36 -0700)
>
> ----------------------------------------------------------------
> target/xtensa: preparation for FLIX support
>
> Separate generation of per-instruction code (such as raising exceptions
> and terminating TB) from per-opcode code.
>

Applied, thanks.

-- PMM
