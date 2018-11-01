Received: from eggs.gnu.org ([2001:4830:134:3::10]:49864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gICxX-00034o-8w
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gICxW-0006on-Hp
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:24:27 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gICxV-0006m6-2t
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 09:24:26 -0400
Received: by mail-ot1-x32a.google.com with SMTP id q1so8265045otk.0
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 06:24:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181030214740.2294043-1-stefanb@linux.vnet.ibm.com>
References: <20181030214740.2294043-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 13:24:02 +0000
Message-ID: <CAFEAcA_LRTScoW3TFt4ck89X5Cm-gshQaAP7Z+LUWZzT8AgaBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/5] Merge tpm 2018/10/29 v2
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

On 30 October 2018 at 21:47, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> This pull request fixes a couple of TPM support related issues,
> such as full initialization of a variable to quiet down valgrind,
> a possible race in the TPM related test cases and marking test
> cases as skipped if swtpm was not found in PATH.
>
>    Stefan
>
>
> The following changes since commit a4d710251fa5aa9ec26de4626f11c78500195d12:
>
>   Merge remote-tracking branch 'remotes/berrange/tags/qcrypto-next-pull-request' into staging (2018-10-24 22:08:42 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-10-29-2
>
> for you to fetch changes up to eff1fe9fd0cebe2293eea9597616f792b6b5ad18:
>
>   tpm: Zero-init structure to avoid uninitialized variables in valgrind log (2018-10-30 17:34:22 -0400)
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
