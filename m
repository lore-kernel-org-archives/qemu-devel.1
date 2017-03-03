Received: from eggs.gnu.org ([2001:4830:134:3::10]:44308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjpND-00029p-Mj
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cjpNC-0000FO-I5
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:44:03 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34488)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cjpNC-0000FE-BK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 10:44:02 -0500
Received: by mail-wr0-x234.google.com with SMTP id l37so76357510wrc.1
	for <qemu-devel@nongnu.org>; Fri, 03 Mar 2017 07:44:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170303131317.23617-1-ehabkost@redhat.com>
References: <20170303131317.23617-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Mar 2017 15:43:40 +0000
Message-ID: <CAFEAcA-XRvFu0nYqgMABqaqJV3pyHUPnq7juLg-6-NAG_bSegw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/1] NUMA documentation update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 3 March 2017 at 13:13, Eduardo Habkost <ehabkost@redhat.com> wrote:
> Sorry for sending this after soft freeze. I just noticed that it
> went through the cracks and I believe the documentation update is
> relevant and simple enough to be included in 2.9.
>
> The following changes since commit 508e038a5d725f2aa729f58a1f5209b9be4227de:
>
>   dtc: Revert unintentional submodule downgrade from commit 077dd74239a99 (2017-03-03 12:48:42 +0000)
>
> are available in the git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/numa-pull-request
>
> for you to fetch changes up to 4b9a5dd762ae41acd7df741de3e554b319a2cced:
>
>   qemu-options: Rewrite -numa documentation (2017-03-03 10:08:03 -0300)
>
> ----------------------------------------------------------------
> NUMA documentation update
>
> ----------------------------------------------------------------
>
> Eduardo Habkost (1):
>   qemu-options: Rewrite -numa documentation
>
>  qemu-options.hx | 38 ++++++++++++++++++++++++++++----------
>  1 file changed, 28 insertions(+), 10 deletions(-

Applied, thanks.

-- PMM
