Received: from eggs.gnu.org ([2001:4830:134:3::10]:58318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fantY-0003kX-S4
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:56:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fantV-0000nd-NQ
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:56:56 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:40404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fantV-0000mp-F5
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 15:56:53 -0400
Received: by mail-qt0-x22b.google.com with SMTP id h4-v6so5389932qtj.7
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 12:56:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180622004435.10291-1-f4bug@amsat.org>
	<20180622004435.10291-5-f4bug@amsat.org> <87in62vq15.fsf@linaro.org>
	<543f19ab-385c-4e77-b243-d6740b456360@amsat.org>
	<87bmbuvjvl.fsf@linaro.org>
	<2a4024fa-dcc7-701d-dd9c-0777aa02869b@amsat.org>
Message-ID: <643265a1-f613-e14f-ac25-900133e52528@amsat.org>
Date: Wed, 4 Jul 2018 16:56:44 -0300
MIME-Version: 1.0
In-Reply-To: <2a4024fa-dcc7-701d-dd9c-0777aa02869b@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="25LkPfWKHJkJAruxkhyQqq7J8xiRLnkMo"
Subject: Re: [Qemu-devel] [PATCH v2 4/6] tests/acceptance: Add a
 BootLinuxConsoleMips test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--25LkPfWKHJkJAruxkhyQqq7J8xiRLnkMo
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Fam Zheng <famz@redhat.com>, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?=
 <ldoktor@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Message-ID: <643265a1-f613-e14f-ac25-900133e52528@amsat.org>
Subject: Re: [PATCH v2 4/6] tests/acceptance: Add a BootLinuxConsoleMips test
References: <20180622004435.10291-1-f4bug@amsat.org>
 <20180622004435.10291-5-f4bug@amsat.org> <87in62vq15.fsf@linaro.org>
 <543f19ab-385c-4e77-b243-d6740b456360@amsat.org> <87bmbuvjvl.fsf@linaro.org>
 <2a4024fa-dcc7-701d-dd9c-0777aa02869b@amsat.org>
In-Reply-To: <2a4024fa-dcc7-701d-dd9c-0777aa02869b@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Alex, Cleber.

On 06/28/2018 07:45 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 06/28/2018 03:36 PM, Alex Benn=C3=A9e wrote:
>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>> On 06/28/2018 01:23 PM, Alex Benn=C3=A9e wrote:
>>>> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>>>>
>>>>> Similar to the BootLinuxConsoleX86_64 test:
>>>>> boot a Linux kernel on a Malta board and verify the serial is worki=
ng.
>>>>>
>>>>> This test can be run using:
>>>>>
>>>>>     $ avocado run -t endian:big tests/acceptance
>>>>>
>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>> ---
>>>>>  tests/acceptance/boot_linux_console.py | 38 ++++++++++++++++++++++=
++++
>>>>>  1 file changed, 38 insertions(+)
>>>>>
>>>>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/accepta=
nce/boot_linux_console.py
>>>>> index 17dc8d58c1..72cf5e943c 100644
>>>>> --- a/tests/acceptance/boot_linux_console.py
>>>>> +++ b/tests/acceptance/boot_linux_console.py
>>>>> @@ -46,3 +46,41 @@ class BootLinuxConsoleX86_64(Test):
>>>>>                  break
>>>>>              if 'Kernel panic - not syncing' in msg:
>>>>>                  self.fail("Kernel panic reached")
>>>>> +
>>>>> +
>>>>> +class BootLinuxConsoleMips(Test):
>>>>> +    """
>>>>> +    Boots a mips Linux kernel and checks that the console is opera=
tional
>>>>> +    and the kernel command line is properly passed from QEMU to th=
e kernel
>>>>> +
>>>>> +    :avocado: enable
>>>>> +    :avocado: tags=3Dendian:big
>>>>> +    :avocado: tags=3Darch:mips
>>>>> +    :avocado: tags=3Dboard:malta
>>>>> +    """
>>>>> +
>>>>> +    arch =3D "mips"
>>>>> +    timeout =3D 60
>>>>> +
>>>>> +    def test(self):
>>>>> +        kernel_url =3D ('http://people.debian.org/~aurel32/qemu/mi=
ps/'
>>>>> +                      'vmlinux-3.2.0-4-4kc-malta')
>>>>> +        kernel_hash =3D '592e384a4edc16dade52a6cd5c785c637bcbc9ad'=

>>>>> +        kernel_path =3D self.fetch_asset(kernel_url,
>>>>> asset_hash=3Dkernel_hash)
>>>>
>>>> I'm uncomfortable using "random" binaries of websites as the source =
of
>>>> our test kernels. I can see the justification for distro kernels as =
they
>>>> at least have the infrastructure to rebuild from source if you reall=
y
>>>> want to, but even then the distros don't cover a lot of the
>>>> architectures.

Alex: I could find all the Linux kernel I'm interested to console-test
with Avocado on the http://snapshot.debian.org/ archive website.

For example Aurelien's one (more up-to-date) is available here:
http://snapshot.debian.org/package/linux-2.6/2.6.32-48/#linux-image-2.6.3=
2-5-4kc-malta_2.6.32-48

I also added a SH-4 test for the SM501 series of Zoltan BALATON using
the kernel extracted from this distrib built kernel:
http://snapshot.debian.org/package/linux-2.6/2.6.32-30/#linux-image-2.6.3=
2-5-sh7751r_2.6.32-30

The Debian distribution also provide the source package and the kernels
can be simply rebuilt using make-kpkg or (make bindeb-pkg with more
recent kernels).

Would it be enough to satisfy the GPL requirements to provided that info
in the header and use these handy pre-compiled kernels?

Cleber: As you added tarballs and zip support, I'd also need a "dpkg"
support in your fetch_asset() archive management...

Cleber: And another future request is to be able to extract files from
ISO images with the guestfish tool :P
To be able to add a test for the Apple Machintosh Quadra 800 machine:
http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg08139.html

>>> And now I notice I made an mistake here :) I guess remember the Avoca=
do
>>> team started using the SHA-1 hash as default and I suggested them to =
be
>>> able to use other hashes for this particular case, since Aurelien
>>> provided the MD5 hashes signed by his GPG key, which is signed/truste=
d
>>> by Peter and used to merge mips32 pulls.
>>>
>>> That would verify the QEMU community circle of trust right?
>>
>> It's not so much the chain of trust and more repeatability of building=

>> the test cases. I trust Aurel32's binaries are good test cases for MIP=
S
>> but at the moment I have no idea how to rebuild them which is a bit of=

>> an issue given it is covered by the GPL.
>=20
> OK! I didn't even think about that since this is a "Linux" kernel and a=

> "Debian" rootfs provided by a Debian developer, hosted on a Debian
> server, so I'm pretty sure this is GPL compliant, but it makes sens.
>=20
> I'll find a way to have reproducible test binaries for acceptance testi=
ng.
>=20
>>> I don't think Avocado should parse the FTP/HTTP signed indexes, but a=

>>> manual verification when merging this series should suffice.
>>>
>>>>
>>>> I had experimented with using docker based builds for building test
>>>> fixtures (see tests/docker/dockerbuilds):
>>>>
>>>>    https://github.com/stsquad/qemu/tree/docker/linux-user-and-ltp-bu=
ilds-v2
>>>>
>>>> As these tests are fairly simple boot tests that just need kernels m=
aybe
>>>> we could look at tooling up the generation of these images in a
>>>> repeatable way - similar to the way vmtest builds VMs.
>>>
>>> Yes, I have another acceptance branch where I cross-build an old mips=
sim
>>> kernel to test the board, using the following:
>>> http://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg04071.html=

>>>
>>> But preparing a Docker cross image, fetching the Linux kernel source,=

>>> building it, takes a lot of time/storage I'd rather avoid; at least w=
ith
>>> Aurelien kernels, since they are known to work since years.
>>
>> Well you can throw away the docker image as long as we have a mechanis=
m
>> to dump out the final binary. I have no interest in forcing people to
>> keep checked out code using up space, just that they can re-build if
>> they need to.
>=20
> The Avocado guys said they have plenty of storage for assets.
> A cool feature would be to have some config built by some CI builder
> that then sign and push reproducible config + generated binary to the
> assets storage automatically.
>=20
>>>>> +
>>>>> +        self.vm.set_machine('malta')
>>>>> +        self.vm.set_console()
>>>>> +        kernel_command_line =3D 'console=3DttyS0 printk.time=3D0'
>>>>> +        self.vm.add_args('-m', "64",
>>>>> +                         '-kernel', kernel_path,
>>>>> +                         '-append', kernel_command_line)
>>>>> +        self.vm.launch()
>>>>> +        console =3D self.vm.console_socket.makefile()
>>>>> +        console_logger =3D logging.getLogger('console')
>>>>> +        while True:
>>>>> +            msg =3D console.readline()
>>>>> +            console_logger.debug(msg.strip())
>>>>> +            if 'Kernel command line: %s' % kernel_command_line in =
msg:
>>>>> +                break
>>>>> +            if 'Kernel panic - not syncing' in msg:
>>>>> +                self.fail("Kernel panic reached")
>>>>
>>>> Of course for bonus points a simple rootfs with hackbench or some su=
ch
>>>> in it would be nice. But I appreciate this makes the building job a =
lot
>>>> more complex than just a kernel.
>>>
>>> My idea is to use the rootfs for larger tests, and tag the "Kernel
>>> panic" tests as "quick", so we can have a "make acceptance-speed" or
>>> similar.
>>>
>>> We can already test than many devices were initialized correctly quic=
kly
>>> looking at this console output.
>>
>> Yeah the kernel boot up is a pretty good smoke test (it's all most of
>> kernelci manages as well). However it certainly doesn't fully exercise=

>> the translator. I've lost track of the number of bugs we found after
>> successfully booting an kernel because we were doing exhaustive
>> instruction testing.
>=20
> This is not indeed a translator test, but simple enough to test than
> devices are instantiated, mapped at the correct address, detected by
> Linux, probe the device enough to initialize it.
>=20
> I actually wrote this test after breaking a I/O device why a previous
> Super I/O refactor, this test would have failed.
>=20
> You could say a simple "info mtree" parser would notice it too... but
> acceptance testing is closer to real-world imho, and would be also
> useful to catch changes in the guest code (as in "QEMU expects things
> that way, but the Linux kernel updated to something new").
>=20
> Regards,
>=20
> Phil.
>=20


--25LkPfWKHJkJAruxkhyQqq7J8xiRLnkMo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAls9Jn4ACgkQ4+MsLN6t
wN6YyxAAzy72kEDECatNkrvGIG6eTzO10S3F5svMWMI6xYEcmqhucazvrMHG0ASC
iDWJSIeNKFSPp77a1IqvZGChjlpHD2T7dvweoFQR/XTQ9feseVjAhykMIsPQkjAm
R8SxnxBy55avc03/9PBRBG30MpgExIwz5wGVkjJnnmFMi+mXE7b4BFC+QgWhNDOg
dnP2R0jbNbrpdNMfz9/EEWSgwe7MlnXbcuALF91p4jS/YbmUcxChk97CaUrfA28C
NA5hFvPksRPxV9F7cQ0rzxnd+Mg+L513lBmitwJbGuVE+8OLOnQSzq4ylMoW3DZQ
Ny+8o6y1srbikFFKc6AYkHmCK+X6ycqneaaqoFCLZANV8zjkhxAUBMVmssFVRKw4
hn/S6BfB81dv9Z2cFyHmjKJ/FX9fdRUeuP0CSKRONvrNYnd/nw/gu0jqH18iS46K
DyzksYNh79FFTuG6NXVJhtcaXQqY3vbXdVOsergkxdD7fJ+pKCt7n/ejPgj7OAOQ
/pDl3mV2NeD50MtEwluQpV/8bt4CfZnJXEaScblrjU92o+sVYk78ySSbGPWAjEmo
cU30btNIoFpLCKAZxJf3mEVaEwpeJ+s8ijr3pqhi8Hnye6cFPBvItYMRMmbcv3L/
5rNmzBs4KL+cIs28+lxUiBYIZ10v+GhW8FzK5hcSAMdSC0obPcI=
=Q2Fb
-----END PGP SIGNATURE-----

--25LkPfWKHJkJAruxkhyQqq7J8xiRLnkMo--
