Received: from eggs.gnu.org ([2001:4830:134:3::10]:58945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emKKi-00015Q-Ha
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:16:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1emKKh-0003wp-Iu
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:16:20 -0500
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:37131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1emKKh-0003wT-Da
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 09:16:19 -0500
Received: by mail-ot0-x234.google.com with SMTP id e64so23494456ote.4
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 06:16:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518607234-17739-1-git-send-email-thuth@redhat.com>
References: <1518607234-17739-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2018 14:15:58 +0000
Message-ID: <CAFEAcA-ewiJCq=4h-W3GiB6-QWRS+qfhT-K_tNg1y7U7N53F1w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/18] qtest patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>

On 14 February 2018 at 11:20, Thomas Huth <thuth@redhat.com> wrote:
> The following changes since commit bec9c64ef7be8063f1192608b83877bc5c9ea217:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2018-02-13 18:24:08 +0000)
>
> are available in the git repository at:
>
>   https://github.com/huth/qemu.git tags/pull-request-2018-02-14
>
> for you to fetch changes up to 02f4fbecb93da2125d22d3f0b62c6ee44aea84d4:
>
>   tests/m48t59: Use the m48t59 test on ppc, too (2018-02-14 11:43:42 +0100)
>
> ----------------------------------------------------------------
> Various improvements to the qtest checks:
> - Clean-ups by Eric Blake with regards to the global_qtest variable
> - Some more test cases for the boot-serial tester
> - Re-activation of the m48t59-test
> ---------------------------------------------------------------

Applied, thanks.

-- PMM
