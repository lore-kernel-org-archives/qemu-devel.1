Received: from eggs.gnu.org ([2001:4830:134:3::10]:42728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBeaj-0002Rd-2L
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fBeai-0006ic-AK
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:57:33 -0400
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:42357)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fBeai-0006iR-4C
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 06:57:32 -0400
Received: by mail-ot0-x233.google.com with SMTP id l13-v6so6790218otk.9
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 03:57:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180425200326.72337-1-dgilbert@redhat.com>
References: <20180425200326.72337-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Apr 2018 11:57:10 +0100
Message-ID: <CAFEAcA8keFUKJMyjVtqs4-NDH9FRcgFjc+sXHbOzhfW07mozxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/16] migration queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, xiaoguangrong@tencent.com

On 25 April 2018 at 21:03, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 4743c23509a51bd4ee85cc272287a41917d1be35:
>
>   Update version for v2.12.0 release (2018-04-24 16:44:55 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20180425a
>
> for you to fetch changes up to da3f56cb2e767016d3f204837a77caf35b463f90:
>
>   migration: remove ram_save_compressed_page() (2018-04-25 18:04:14 +0100)
>
> ----------------------------------------------------------------
> Migration pull for 2.13
>
> Alexey Perevalov's postcopy blocktime statistics
> Xiao Guangrong's compression performance improvements

Applied, thanks.

-- PMM
