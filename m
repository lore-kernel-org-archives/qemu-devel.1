Received: from eggs.gnu.org ([2001:4830:134:3::10]:46396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ej8n5-0001l1-Lh
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ej8n0-0003Gd-K1
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:20:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57258 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ej8n0-0003Fr-Ab
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 14:20:22 -0500
References: <1517935008-4702-1-git-send-email-thuth@redhat.com>
	<CAJ+F1C+ANqgDZ+GteFCKKe1Q+LhMKWHc5euE4tH7GqqqG1pB-w@mail.gmail.com>
	<05855137-ae63-b264-f058-7b5f59b61f4a@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c9c3d5e6-642b-74d2-28ab-67f4f5f0720f@redhat.com>
Date: Tue, 6 Feb 2018 20:20:13 +0100
MIME-Version: 1.0
In-Reply-To: <05855137-ae63-b264-f058-7b5f59b61f4a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Eduardo Otubo <otubo@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, Kashyap Chamarthy <kchamart@redhat.com>, QEMU <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 06/02/2018 19:44, Thomas Huth wrote:
> Sure, I can add them ... actually, there are even some more talks
> related to KVM , e.g. the one from Vitaly:
> 
>  https://fosdem.org/2018/schedule/event/vai_kvm_on_hyperv/
> 
> or related to Xen:
> 
>  https://fosdem.org/2018/schedule/event/vai_pci_emulation/
> 
> But the problem is: Where to draw the line? E.g. there was also a talk
> about DOSEMU2 which can now use KVM, too. And if we include the lower
> layer, should the list also include the upper layers like libvirt?
> oVirt? KubeVirt? ... Well, I'd say since this blog post is for the QEMU
> blog, we should really limit it to talks that are at least partly about
> using or improving QEMU directly. So I'd maybe include the virtio talk,
> but things that only affect KVM should maybe rather go into a KVM blog
> somewhere else? (www.linux-kvm.org does not have a blog yet, does it?)

No, it doesn't.  You're right, Vitaly and Roger's talks do not have much
to do with QEMU so I think it's okay to draw the line at Jens's, plus
include a link to the VaI devroom.

Thanks,

Paolo
