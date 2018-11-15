Received: from eggs.gnu.org ([2001:4830:134:3::10]:41790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNIwr-0000ky-V5
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:48:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gNIwr-0006Gx-8N
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:48:49 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:44744)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gNIwp-0006Eu-Ev
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 09:48:47 -0500
Received: by mail-ot1-x32d.google.com with SMTP id z33so18207816otz.11
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 06:48:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181115140949.3481699-1-stefanb@linux.vnet.ibm.com>
References: <20181115140949.3481699-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Nov 2018 14:48:25 +0000
Message-ID: <CAFEAcA9keG3gVZHi0mESjxgOHL=np8LKThpGzfVzcBCxzAHURw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/2] Merge tpm 2018/11/15 v1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 15 November 2018 at 14:09, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> The 2 patches in this series fix some minor issues.
>
>    Stefan
>
> The following changes since commit cb968d275c145467c8b385a3618a207ec111eab1:
>
>   Update version for v3.1.0-rc1 release (2018-11-13 18:16:14 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-11-15-1
>
> for you to fetch changes up to 5e58b58c478bd00c807bd7814ccab148d49cc901:
>
>   tests: tpm: Use g_test_message rather than fprintf (2018-11-14 16:12:24 -0500)
>
> ----------------------------------------------------------------
> Prasad J Pandit (1):
>       tpm: use loop iterator to set sts data field
>
> Stefan Berger (1):
>       tests: tpm: Use g_test_message rather than fprintf

Applied, thanks.

-- PMM
