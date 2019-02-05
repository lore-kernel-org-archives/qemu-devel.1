Received: from eggs.gnu.org ([209.51.188.92]:57105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gr98U-0007Kr-Dy
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 17:24:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brad@comstyle.com>) id 1gr98T-0003E0-He
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 17:24:10 -0500
References: <20190129175403.18017-1-philmd@redhat.com>
	<20190129175403.18017-10-philmd@redhat.com>
	<CAFEAcA_ejg0yPkBZ_0-mgM5zgMHKqKe3SDGX0wMZ-neYC_Oy0A@mail.gmail.com>
	<e5dd8130-e041-7774-2141-cc506dee99f7@redhat.com>
	<94f74717-0bab-ea0a-e7cc-239a1b1136bf@comstyle.com>
	<e8177680-28fc-1213-a8f7-a3b94ef92e15@redhat.com>
From: Brad Smith <brad@comstyle.com>
Message-ID: <f49796e8-7779-f8f3-a3a7-c4189d66d9de@comstyle.com>
Date: Tue, 5 Feb 2019 17:24:02 -0500
MIME-Version: 1.0
In-Reply-To: <e8177680-28fc-1213-a8f7-a3b94ef92e15@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/18] tests/vm/openbsd: Install Bash
 from the ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On 2/5/2019 9:23 AM, Philippe Mathieu-Daud=C3=A9 wrote:

> Hi Brad,
>
> On 2/5/19 2:57 PM, Brad Smith wrote:
>> If someone could point me in the right direction as to how the image i=
s
>> created
>> I could look at coming up with something newer. I would prefer that ov=
er
>> some
>> of the workarounds I've seen to date.
> I'm not an OpenBSD user, so I'm more than happy if you can help the
> upstream community to test QEMU codebase on this OS. Testing helps us t=
o
> avoid code rot.
>
> What we currently use to run tests is the 'tests/vm/openbsd' script.
> The script itself doesn't document how it was built, but looking at the
> commit of his introduction fdfaa33291eb we have:
>
>      The image is prepared following instructions as in:
>
>      https://wiki.qemu.org/Hosts/BSD

Ok, well that brings me to my next question. How do I get access to the=20
Wiki to update
the instructions?
