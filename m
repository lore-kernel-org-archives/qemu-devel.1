Received: from eggs.gnu.org ([2001:4830:134:3::10]:48656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJk5K-0005SY-V7
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gJk5J-0001Gr-VL
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:58:50 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gJk5J-0000ug-IK
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 13:58:49 -0500
Received: by mail-ot1-x344.google.com with SMTP id g10so9004645otl.12
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 10:58:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Nov 2018 18:58:02 +0000
Message-ID: <CAFEAcA9y8TPeoJYeu=OMBS+ruJEa73As8nTo1kXP42Jp6G_rKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/36] Block layer patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 5 November 2018 at 16:37, Kevin Wolf <kwolf@redhat.com> wrote:
> The following changes since commit b2f7a038bb4c4fc5ce6b8486e8513dfd97665e2a:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-softfloat-20181104' into staging (2018-11-05 10:32:49 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 1240ac558d348f6c7a5752b1a57c1da58e4efe3e:
>
>   include: Add a comment to explain the origin of sizes' lookup table (2018-11-05 15:29:59 +0100)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - auto-read-only option to fix commit job when used with -blockdev
> - Fix help text related qemu-iotests failure (by improving the help text
>   and updating the reference output)
> - quorum: Add missing checks when adding/removing child nodes
> - Don't take address of fields in packed structs
> - vvfat: Fix crash when reporting error about too many files in directory
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
