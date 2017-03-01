Received: from eggs.gnu.org ([2001:4830:134:3::10]:36609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj5Jv-0001eN-Hi
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:33:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cj5Ju-0001Vk-Af
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:33:35 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38808)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cj5Jt-0001VG-S2
	for qemu-devel@nongnu.org; Wed, 01 Mar 2017 09:33:34 -0500
Received: by mail-wm0-x230.google.com with SMTP id u199so37882059wmd.1
	for <qemu-devel@nongnu.org>; Wed, 01 Mar 2017 06:33:33 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488277840-18608-1-git-send-email-groug@kaod.org>
References: <1488277840-18608-1-git-send-email-groug@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Mar 2017 14:33:11 +0000
Message-ID: <CAFEAcA9UNAmhT39JAK1DB0OMGEn8-BHOYaBh32BwzJvW7TQh9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 00/28] 9p CVE-2016-9602 fixes 2017-02-28 for
 2.9 soft freeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On 28 February 2017 at 10:30, Greg Kurz <groug@kaod.org> wrote:
> The following changes since commit 9b9fbe8a4e9eec9072ee2697a6af59144442785f:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/pull-ui-20170227-1' into staging (2017-02-27 19:19:46 +0000)
>
> are available in the git repository at:
>
>   https://github.com/gkurz/qemu.git tags/cve-2016-9602-for-upstream
>
> for you to fetch changes up to c23d5f1d5bc0e23aeb845b1af8f996f16783ce98:
>
>   9pfs: local: drop unused code (2017-02-28 11:21:15 +0100)
>
> ----------------------------------------------------------------
> This pull request have all the fixes for CVE-2016-9602, so that it can
> be easily picked up by downstreams, as suggested by Michel Tokarev.
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
