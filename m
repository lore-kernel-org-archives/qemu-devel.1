Received: from eggs.gnu.org ([2001:4830:134:3::10]:51247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cK297-0004GD-Sf
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cK293-00058W-Kl
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:06:50 -0500
Received: from mail-vk0-x236.google.com ([2607:f8b0:400c:c05::236]:35081)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cK293-00058F-GM
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:06:49 -0500
Received: by mail-vk0-x236.google.com with SMTP id y197so15008065vky.2
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 04:06:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1482268598-27422-1-git-send-email-thuth@redhat.com>
References: <1482268598-27422-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Dec 2016 12:06:28 +0000
Message-ID: <CAFEAcA-GHRcabKA4-PCaTWizGBTmfoZt_-iiqQ=u7WU75hZVLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] Move target-xxx folders to target/
 folder
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

On 20 December 2016 at 21:16, Thomas Huth <thuth@redhat.com> wrote:
> The following changes since commit 82ecffa8c050bf5bbc13329e9b65eac1caa5b55c:
>
>   Open 2.9 development tree (2016-12-20 16:20:16 +0000)
>
> are available in the git repository at:
>
>   https://github.com/huth/qemu.git tags/target-dirs-20161220
>
> for you to fetch changes up to fcf5ef2ab52c621a4617ebbef36bf43b4003f4c0:
>
>   Move target-* CPU file into a target/ folder (2016-12-20 21:52:12 +0100)
>
> ----------------------------------------------------------------
> Move target-xxx folders to target/ directory
>
> ----------------------------------------------------------------
> Thomas Huth (1):
>   Move target-* CPU file into a target/ folder

Applied to master, thanks.

-- PMM
