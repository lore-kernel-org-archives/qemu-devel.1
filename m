Received: from eggs.gnu.org ([2001:4830:134:3::10]:43868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej6vq-0006oy-1g
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:21:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ej6vl-0003f8-S2
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:21:22 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ej6vl-0003cL-L5
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:21:17 -0500
Received: by mail-wm0-x243.google.com with SMTP id v123so5328210wmd.5
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 09:21:17 -0800 (PST)
References: <1517935008-4702-1-git-send-email-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1517935008-4702-1-git-send-email-thuth@redhat.com>
Date: Tue, 06 Feb 2018 17:21:14 +0000
Message-ID: <87a7wmvxth.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post with the
 presentations from DevConf and FOSDEM 2018
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Otubo <otubo@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>


Thomas Huth <thuth@redhat.com> writes:

> Let's provide some links to the videos from DevConf and FOSDEM.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  I've tried my best to find all talks that are related to QEMU, not sure
>  whether I've correctly identified all of them. If you are aware of any
>  other talk that should be in the list here, please let me know.
>
>  _posts/2018-02-06-devconf-fosdem.md | 37 +++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 _posts/2018-02-06-devconf-fosdem.md
>
> diff --git a/_posts/2018-02-06-devconf-fosdem.md b/_posts/2018-02-06-devc=
onf-fosdem.md
> new file mode 100644
> index 0000000..48eb7bf
> --- /dev/null
> +++ b/_posts/2018-02-06-devconf-fosdem.md
> @@ -0,0 +1,37 @@
> +---
> +layout: post
> +title:  "Presentations from DevConf and FOSDEM 2018"
> +date:   2018-02-06 17:00:00 +0100
> +author: Thomas Huth
> +categories: [presentations, conferences]
> +---
> +During the past two weeks, there were two important conferences for Open
> +Source developers in Europe, where you could also enjoy some QEMU related
> +presentations. The following QEMU-related talks were held at the
> +[DevConf 2018](https://devconf.cz/cz/2018) conference in Brno:
> +
> +* [Eliminating guest page cache](https://www.youtube.com/watch?v=3DNG0n5=
MTXOa4)
> +  by Pankaj Gupta
> +
> +* [Anatomy of KVM Guest](https://www.youtube.com/watch?v=3Dt-MSukwDqeM)
> +  by Prasad J Pandit
> +
> +* [QEMU Sandboxing for dummies](https://www.youtube.com/watch?v=3D_7yGia=
fZdVc)
> +  by Eduardo Otubo
> +
> +And at the [FOSDEM 2018](https://fosdem.org/2018/) in Brussels, you could
> +listen to the following QEMU related talks:
> +
> +* [QEMU in UEFI](https://fosdem.org/2018/schedule/event/vai_qemu_in_uefi=
/)
> +  by Alexander Graf
> +
> +* [Live Block Device Operations in
> +   QEMU](https://fosdem.org/2018/schedule/event/vai_qemu_live_dev_operat=
ions/)
> +  by Kashyap Chamarthy
> +
> +* [Vectors Meet
> +   Virtualization](https://fosdem.org/2018/schedule/event/vai_vectors_me=
et_virtualization/)
> +  by Alex Benn=C3=A9e
> +
> +* [Finding your way through the QEMU parameter
> +  jungle](https://fosdem.org/2018/schedule/event/vai_qemu_jungle/)


--
Alex Benn=C3=A9e
