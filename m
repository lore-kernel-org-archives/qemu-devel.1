Received: from eggs.gnu.org ([2001:4830:134:3::10]:44912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ej6zj-0001t4-Ed
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:25:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ej6zi-0007HM-1M
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:25:23 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:44682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ej6zh-0007H7-PQ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:25:21 -0500
Received: by mail-wr0-x244.google.com with SMTP id v31so2769457wrc.11
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 09:25:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517935008-4702-1-git-send-email-thuth@redhat.com>
References: <1517935008-4702-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 6 Feb 2018 18:25:19 +0100
Message-ID: <CAJ+F1C+ANqgDZ+GteFCKKe1Q+LhMKWHc5euE4tH7GqqqG1pB-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: QEMU <qemu-devel@nongnu.org>, Eduardo Otubo <otubo@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Kashyap Chamarthy <kchamart@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hi

On Tue, Feb 6, 2018 at 5:36 PM, Thomas Huth <thuth@redhat.com> wrote:
> Let's provide some links to the videos from DevConf and FOSDEM.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
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
> +Source developers in Europe, where you could also enjoy some QEMU relate=
d
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
> +And at the [FOSDEM 2018](https://fosdem.org/2018/) in Brussels, you coul=
d
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

You may perhaps add

"What's new in the next version of the Virtio standard"
(https://fosdem.org/2018/schedule/event/virtio/)
by Jens Freimann

And also point out the rest of virtualization related talks:
https://fosdem.org/2018/schedule/track/virtualization_and_iaas/

There was also an interesting talk about "Using KVM to sandbox
firmwares from the Linux Kernel"
(https://fosdem.org/2018/schedule/event/hwenablement_using_kvm_to_sandbox_f=
irmware/),
although it is further away from qemu, it is worth it.

the initial list looks fine, so either way
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
