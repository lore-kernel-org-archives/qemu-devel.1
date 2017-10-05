Received: from eggs.gnu.org ([2001:4830:134:3::10]:36052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e09PB-0002Yk-Cq
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:53:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e09PA-0005f9-Iw
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:53:49 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:51551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e09PA-0005en-Cd
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 12:53:48 -0400
Received: by mail-wm0-x229.google.com with SMTP id f4so3435094wme.0
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 09:53:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507222112-20315-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1507222112-20315-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Oct 2017 17:53:26 +0100
Message-ID: <CAFEAcA8XevNGXiKP+-+rNjG1g1C7cOu1e43OaMdh7P4C5Qgh8g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 00/10] Merge tpm 2017/10/04
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, amarnath.valluri@intel.com, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>

On 5 October 2017 at 17:48, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> The following changes since commit d147f7e815f97cb477e223586bcb80c316ae10ea:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-10-03 16:27:24 +0100)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-10-04-1
>
> for you to fetch changes up to 5e64d0182fe9d1c9caa347c5bee0a0591f9be2ef:
>
>   specs: Describe the TPM support in QEMU (2017-10-05 12:39:15 -0400)
>
> ----------------------------------------------------------------
> Merge tpm 2017/10/04 v1
>

Hi; this pull request appears to be signed with a gpg key that
isn't signed by anybody else... Are there other people you work
with at IBM who can verify your id and sign your key for you?

thanks
-- PMM
