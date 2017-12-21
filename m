Received: from eggs.gnu.org ([2001:4830:134:3::10]:50617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS3nV-0007I6-3p
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eS3nU-0006Wz-CB
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:34:17 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:37147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eS3nU-0006Wi-7u
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 11:34:16 -0500
Received: by mail-ot0-x244.google.com with SMTP id p31so16299916ota.4
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 08:34:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171221015234.9912-1-famz@redhat.com>
References: <20171221015234.9912-1-famz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Dec 2017 16:33:55 +0000
Message-ID: <CAFEAcA9H7zdZj2Q5TeGPZUx9rftnm=tZFqXZPgqs1YfZA2kM_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/2] Docker and UUID patches for 2.12
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

On 21 December 2017 at 01:52, Fam Zheng <famz@redhat.com> wrote:
> The following changes since commit 411ad78115ebeb3411cf4b7622784b93dfabe259:
>
>   Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2017-12-15-1' into staging (2017-12-17 15:27:41 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/famz/qemu.git tags/staging-pull-request
>
> for you to fetch changes up to bfab1aede07f864b8fbd749c3a0545b949b4cc84:
>
>   util: add is_equal to UUID API (2017-12-20 22:01:24 +0800)
>
> ----------------------------------------------------------------
>
> Patch 1 is also in Paolo's pull but it shouldn't be a problem.
>

Applied, thanks.

-- PMM
