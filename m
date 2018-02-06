Received: from eggs.gnu.org ([2001:4830:134:3::10]:49844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ej7K7-0005fL-9k
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ej7K2-0003Mr-EU
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:46:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ej7K2-0003Me-7a
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 12:46:22 -0500
References: <1517935008-4702-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a3fddc44-0e80-c90f-ab71-bec401bd3717@redhat.com>
Date: Tue, 6 Feb 2018 18:46:13 +0100
MIME-Version: 1.0
In-Reply-To: <1517935008-4702-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Otubo <otubo@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Pankaj Gupta <pagupta@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>

On 06/02/2018 17:36, Thomas Huth wrote:
> Let's provide some links to the videos from DevConf and FOSDEM.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  I've tried my best to find all talks that are related to QEMU, not sur=
e
>  whether I've correctly identified all of them. If you are aware of any
>  other talk that should be in the list here, please let me know.

That's already a great list, but please add those that Marc-Andr=C3=A9 me=
ntioned.

Thanks for working on qemu.org!

Paolo

>  _posts/2018-02-06-devconf-fosdem.md | 37 +++++++++++++++++++++++++++++=
++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 _posts/2018-02-06-devconf-fosdem.md
>=20
> diff --git a/_posts/2018-02-06-devconf-fosdem.md b/_posts/2018-02-06-de=
vconf-fosdem.md
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
> +During the past two weeks, there were two important conferences for Op=
en
> +Source developers in Europe, where you could also enjoy some QEMU rela=
ted
> +presentations. The following QEMU-related talks were held at the
> +[DevConf 2018](https://devconf.cz/cz/2018) conference in Brno:
> +
> +* [Eliminating guest page cache](https://www.youtube.com/watch?v=3DNG0=
n5MTXOa4)
> +  by Pankaj Gupta
> +
> +* [Anatomy of KVM Guest](https://www.youtube.com/watch?v=3Dt-MSukwDqeM=
)
> +  by Prasad J Pandit
> +
> +* [QEMU Sandboxing for dummies](https://www.youtube.com/watch?v=3D_7yG=
iafZdVc)
> +  by Eduardo Otubo
> +
> +And at the [FOSDEM 2018](https://fosdem.org/2018/) in Brussels, you co=
uld
> +listen to the following QEMU related talks:
> +
> +* [QEMU in UEFI](https://fosdem.org/2018/schedule/event/vai_qemu_in_ue=
fi/)
> +  by Alexander Graf
> +
> +* [Live Block Device Operations in
> +   QEMU](https://fosdem.org/2018/schedule/event/vai_qemu_live_dev_oper=
ations/)
> +  by Kashyap Chamarthy
> +
> +* [Vectors Meet
> +   Virtualization](https://fosdem.org/2018/schedule/event/vai_vectors_=
meet_virtualization/)
> +  by Alex Benn=C3=A9e
> +
> +* [Finding your way through the QEMU parameter
> +  jungle](https://fosdem.org/2018/schedule/event/vai_qemu_jungle/)
>=20
