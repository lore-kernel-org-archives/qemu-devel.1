Received: from eggs.gnu.org ([2001:4830:134:3::10]:35210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ej8Ev-0005bA-Ox
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:45:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ej8Er-0005DH-Qq
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:45:09 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33122 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ej8Er-0005D4-Lc
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:45:05 -0500
References: <1517935008-4702-1-git-send-email-thuth@redhat.com>
	<CAJ+F1C+ANqgDZ+GteFCKKe1Q+LhMKWHc5euE4tH7GqqqG1pB-w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <05855137-ae63-b264-f058-7b5f59b61f4a@redhat.com>
Date: Tue, 6 Feb 2018 19:44:53 +0100
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+ANqgDZ+GteFCKKe1Q+LhMKWHc5euE4tH7GqqqG1pB-w@mail.gmail.com>
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
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Eduardo Otubo <otubo@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Kashyap Chamarthy <kchamart@redhat.com>, QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06.02.2018 18:25, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Tue, Feb 6, 2018 at 5:36 PM, Thomas Huth <thuth@redhat.com> wrote:
>> Let's provide some links to the videos from DevConf and FOSDEM.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  I've tried my best to find all talks that are related to QEMU, not su=
re
>>  whether I've correctly identified all of them. If you are aware of an=
y
>>  other talk that should be in the list here, please let me know.
>>
>>  _posts/2018-02-06-devconf-fosdem.md | 37 ++++++++++++++++++++++++++++=
+++++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100644 _posts/2018-02-06-devconf-fosdem.md
>>
>> diff --git a/_posts/2018-02-06-devconf-fosdem.md b/_posts/2018-02-06-d=
evconf-fosdem.md
>> new file mode 100644
>> index 0000000..48eb7bf
>> --- /dev/null
>> +++ b/_posts/2018-02-06-devconf-fosdem.md
>> @@ -0,0 +1,37 @@
>> +---
>> +layout: post
>> +title:  "Presentations from DevConf and FOSDEM 2018"
>> +date:   2018-02-06 17:00:00 +0100
>> +author: Thomas Huth
>> +categories: [presentations, conferences]
>> +---
>> +During the past two weeks, there were two important conferences for O=
pen
>> +Source developers in Europe, where you could also enjoy some QEMU rel=
ated
>> +presentations. The following QEMU-related talks were held at the
>> +[DevConf 2018](https://devconf.cz/cz/2018) conference in Brno:
>> +
>> +* [Eliminating guest page cache](https://www.youtube.com/watch?v=3DNG=
0n5MTXOa4)
>> +  by Pankaj Gupta
>> +
>> +* [Anatomy of KVM Guest](https://www.youtube.com/watch?v=3Dt-MSukwDqe=
M)
>> +  by Prasad J Pandit
>> +
>> +* [QEMU Sandboxing for dummies](https://www.youtube.com/watch?v=3D_7y=
GiafZdVc)
>> +  by Eduardo Otubo
>> +
>> +And at the [FOSDEM 2018](https://fosdem.org/2018/) in Brussels, you c=
ould
>> +listen to the following QEMU related talks:
>> +
>> +* [QEMU in UEFI](https://fosdem.org/2018/schedule/event/vai_qemu_in_u=
efi/)
>> +  by Alexander Graf
>> +
>> +* [Live Block Device Operations in
>> +   QEMU](https://fosdem.org/2018/schedule/event/vai_qemu_live_dev_ope=
rations/)
>> +  by Kashyap Chamarthy
>> +
>> +* [Vectors Meet
>> +   Virtualization](https://fosdem.org/2018/schedule/event/vai_vectors=
_meet_virtualization/)
>> +  by Alex Benn=C3=A9e
>> +
>> +* [Finding your way through the QEMU parameter
>> +  jungle](https://fosdem.org/2018/schedule/event/vai_qemu_jungle/)
>=20
> You may perhaps add
>=20
> "What's new in the next version of the Virtio standard"
> (https://fosdem.org/2018/schedule/event/virtio/)
> by Jens Freimann
>=20
> And also point out the rest of virtualization related talks:
> https://fosdem.org/2018/schedule/track/virtualization_and_iaas/
>=20
> There was also an interesting talk about "Using KVM to sandbox
> firmwares from the Linux Kernel"
> (https://fosdem.org/2018/schedule/event/hwenablement_using_kvm_to_sandb=
ox_firmware/),
> although it is further away from qemu, it is worth it.

Sure, I can add them ... actually, there are even some more talks
related to KVM , e.g. the one from Vitaly:

 https://fosdem.org/2018/schedule/event/vai_kvm_on_hyperv/

or related to Xen:

 https://fosdem.org/2018/schedule/event/vai_pci_emulation/

But the problem is: Where to draw the line? E.g. there was also a talk
about DOSEMU2 which can now use KVM, too. And if we include the lower
layer, should the list also include the upper layers like libvirt?
oVirt? KubeVirt? ... Well, I'd say since this blog post is for the QEMU
blog, we should really limit it to talks that are at least partly about
using or improving QEMU directly. So I'd maybe include the virtio talk,
but things that only affect KVM should maybe rather go into a KVM blog
somewhere else? (www.linux-kvm.org does not have a blog yet, does it?)

> the initial list looks fine, so either way
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!

 Thomas
