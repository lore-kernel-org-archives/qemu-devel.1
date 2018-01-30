Received: from eggs.gnu.org ([2001:4830:134:3::10]:50275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egZA7-0004Ly-66
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egZA5-00042n-Jd
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:53:35 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:32975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egZA5-00042S-DM
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:53:33 -0500
Received: by mail-oi0-x241.google.com with SMTP id l8so8303943oig.0
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 08:53:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517264719-18288-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517264719-18288-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jan 2018 16:53:12 +0000
Message-ID: <CAFEAcA9eY4JFdHThCXFSW5iFSk16vUj65Sxgj8=seG0Wihm3_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/6] Merge tpm 2018/01/26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 29 January 2018 at 22:25, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> The patches in this pull request fix a bug in the initialization of
> a variable, adapt the cancel path used by the passthrough device to the
> sysfs path of more recent versions of the Linux kernel, and do some other
> cleanups preparing for support of migration. Finally, we add the CRB
> interface emulation, which is used with a TPM 2.
>
> The following changes since commit 0d1442912b3d6591a57ee45fbf28bc91e58d9e76:
>
>   Merge remote-tracking branch 'remotes/jasowang/tags/net-pull-request' into staging (2018-01-29 14:29:17 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-01-26-2
>
> for you to fetch changes up to 4ab6cb4c62273bb46102e5ae1d6af691b47cbcd8:
>
>   tpm: add CRB device (2018-01-29 14:22:50 -0500)
>
> ----------------------------------------------------------------
> Merge tpm 2018/01/26 v2
>

Applied, thanks.

-- PMM
