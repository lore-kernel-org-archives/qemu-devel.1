Received: from eggs.gnu.org ([2001:4830:134:3::10]:39696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQs5n-0002Dt-52
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQs5m-0005QZ-Ai
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:24:31 -0400
Received: from mail-ot0-x242.google.com ([2607:f8b0:4003:c0f::242]:42870)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQs5m-0005Pv-2W
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:24:30 -0400
Received: by mail-ot0-x242.google.com with SMTP id 92-v6so10877801otw.9
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 03:24:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180606195805.185833-1-stefanb@linux.vnet.ibm.com>
References: <20180606195805.185833-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Jun 2018 11:24:08 +0100
Message-ID: <CAFEAcA-r2kgMZ6wrccm1YsVJTkTVkiMtvGjf3pYm-ytzk1xYWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/4] Merge tpm 2018/06/06
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

On 6 June 2018 at 20:58, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> This series of patches refactors existing TPM test code and adds another
> TPM TIS test case testing TPM migration.
>
>     Stefan
>
> The following changes since commit c1c2a435905ae76b159c573b0c0d6f095b45ebc6:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-docker-updates-050618-1' into staging (2018-06-05 17:06:23 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-06-06-1
>
> for you to fetch changes up to 70663851ed4242435676c0bc288efbc1bc4ccf87:
>
>   test: Add swtpm migration test for the TPM TIS interface (2018-06-06 15:44:12 -0400)
>
> ----------------------------------------------------------------
> Merge tpm 2018/06/06 v1
>
> ----------------------------------------------------------------
> Stefan Berger (4):
>       test: Move reusable code from tpm-crb-swtpm-test.c to tpm-util.c
>       test: Move common TPM test functions to tpm-tests.c
>       test: Pass TPM interface model to functions creating command line
>       test: Add swtpm migration test for the TPM TIS interface
>

Applied, thanks.

-- PMM
