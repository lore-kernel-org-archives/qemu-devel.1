Received: from eggs.gnu.org ([209.51.188.92]:56139)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gp61B-0000nI-6Z
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 01:40:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gp618-0003Yo-QN
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 01:40:07 -0500
References: <mhng-a324878c-b61d-4d8d-80bf-e15404469ef7@palmer-si-x1c4>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <547f1afb-cce5-e456-5466-87ba333859b8@redhat.com>
Date: Thu, 31 Jan 2019 07:39:35 +0100
MIME-Version: 1.0
In-Reply-To: <mhng-a324878c-b61d-4d8d-80bf-e15404469ef7@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PR RFC] RISC-V Patches for 3.2, Part 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Palmer Dabbelt <palmer@sifive.com>, eblake@redhat.com
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>

On 2019-01-30 20:01, Palmer Dabbelt wrote:
> On Wed, 30 Jan 2019 09:45:33 PST (-0800), eblake@redhat.com wrote:
>> On 1/30/19 11:35 AM, Palmer Dabbelt wrote:
>>> The following changes since commit
>>> 5385a5988c8a55bebdc878c05b96648579b5d6e0:
>>>
>>> =C2=A0 hw/virtio/virtio-balloon: zero-initialize the virtio_balloon_c=
onfig
>>> struct (2019-01-21 17:20:36 +0000)
>>>
>>> are available in the Git repository at:
>>>
>>> =C2=A0 git://github.com/palmer-dabbelt/qemu.git
>>> tags/riscv-for-master-3.2-part3
>>>
>>> for you to fetch changes up to 461ab9de46d085a37b0da6f096aadc4e0dda4d=
4c:
>>>
>>> =C2=A0 target/riscv: fix counter-enable checks in ctr() (2019-01-29
>>> 11:33:38 -0800)
>>>
>>> ----------------------------------------------------------------
>>> RISC-V Patches for 3.2, Part 3
>>
>> There is no 3.2 release; the next release is named 4.0.=C2=A0 However,=
 if you
>> don't want to bother with sending a v2 pull request just to fix the
>> merge commit message, that's okay with me.
>=20
> Ah, sorry.=C2=A0 I think I'm just going to leave it as is, I'll get it =
right
> next time.

Also note that you used "PR RFC" in the title ... so not sure whether
Peter's scripts will catch this PR as a valid one...

 Thomas
