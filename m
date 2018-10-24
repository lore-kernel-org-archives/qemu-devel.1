Received: from eggs.gnu.org ([2001:4830:134:3::10]:35269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFL9I-0004wd-5D
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 11:32:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gFL9H-00013Z-5G
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 11:32:44 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:38141)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gFL9G-0000z0-TU
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 11:32:43 -0400
Received: by mail-ot1-x331.google.com with SMTP id l1so5446353otj.5
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 08:32:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1540374728-27579-1-git-send-email-thuth@redhat.com>
References: <1540374728-27579-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 24 Oct 2018 16:32:04 +0100
Message-ID: <CAFEAcA_MJb06vGTonXEvJWUeETf2gqQokE5CpwxeLkb+uQe_fQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] qtest,
 Makefiles and shell script improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 24 October 2018 at 10:52, Thomas Huth <thuth@redhat.com> wrote:
>  Hi Peter,
>
> the following changes since commit 13399aad4fa87b2878c49d02a5d3bafa6c966ba3:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2018-10-22' into staging (2018-10-23 17:20:23 +0100)
>
> are available in the git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2018-10-24
>
> for you to fetch changes up to 86583a07c4a7d55b04db5942a70d176f5299144a:
>
>   configure: Provide option to explicitly disable AVX2 (2018-10-24 07:39:10 +0100)
>
> ----------------------------------------------------------------
> - Disable migration-test with TCG on s390x (since there are known problems)
> - Small Makefile improvements
> - More modern shell scripting changes (use $() instead of ``)
> - Add a configure option to disable AVX2
> ----------------------------------------------------------------



Applied, thanks.

-- PMM
