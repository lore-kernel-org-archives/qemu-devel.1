Received: from eggs.gnu.org ([2001:4830:134:3::10]:49024)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dMueN-0007ru-BZ
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:15:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dMueK-0004kj-3E
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 07:15:19 -0400
References: <20170531120049.14111-1-n54@gmx.com>
	<26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
	<df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
	<877f0p38tr.fsf@dusky.pond.sub.org>
	<b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
	<55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
	<CAFEAcA_2X6QRBS_mbL15Rkq51HxTAX-vb9TJQxKMnwuRsixkiw@mail.gmail.com>
	<6620e2b9-6cc7-48fc-6ecf-4065718d765d@gmx.com>
	<cdc49669-c996-b84d-8110-b7b62ada8ad0@gmx.com>
	<87lgoz98mc.fsf@dusky.pond.sub.org>
	<03bf9574-79a4-0778-bb6d-e0a6da7d1d86@gmx.com>
	<87poe0qv7u.fsf@dusky.pond.sub.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <ef43a52a-b1bb-d062-8ece-1b82daddd959@gmx.com>
Date: Mon, 19 Jun 2017 13:06:09 +0200
MIME-Version: 1.0
In-Reply-To: <87poe0qv7u.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tFfVUIvqtEmwTTfVC0vaqKNFMs9aGkpen"
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH v3] ivshmem-server:
 ivshmem-client: Build when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tFfVUIvqtEmwTTfVC0vaqKNFMs9aGkpen
From: Kamil Rytarowski <n54@gmx.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Message-ID: <ef43a52a-b1bb-d062-8ece-1b82daddd959@gmx.com>
Subject: Re: [Qemu-trivial] [Qemu-devel] [PATCH v3] ivshmem-server:
 ivshmem-client: Build when eventfd() is available
References: <20170531120049.14111-1-n54@gmx.com>
 <26b48c35-b6cc-708d-c4d2-b26a9382e10a@msgid.tls.msk.ru>
 <df623a80-4017-2e79-6bf3-7c402f24b275@gmx.com>
 <877f0p38tr.fsf@dusky.pond.sub.org>
 <b60c5d7b-6ae7-4aa0-6263-b96c964b9195@msgid.tls.msk.ru>
 <55dd32a9-7f01-93e3-e22e-3826dcef1d9d@gmx.com>
 <CAFEAcA_2X6QRBS_mbL15Rkq51HxTAX-vb9TJQxKMnwuRsixkiw@mail.gmail.com>
 <6620e2b9-6cc7-48fc-6ecf-4065718d765d@gmx.com>
 <cdc49669-c996-b84d-8110-b7b62ada8ad0@gmx.com>
 <87lgoz98mc.fsf@dusky.pond.sub.org>
 <03bf9574-79a4-0778-bb6d-e0a6da7d1d86@gmx.com>
 <87poe0qv7u.fsf@dusky.pond.sub.org>
In-Reply-To: <87poe0qv7u.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 19.06.2017 09:42, Markus Armbruster wrote:
> Kamil Rytarowski <n54@gmx.com> writes:
>=20
>> On 10.06.2017 17:15, Markus Armbruster wrote:
>>> Kamil Rytarowski <n54@gmx.com> writes:
>>>
>>>> On 06.06.2017 16:56, Kamil Rytarowski wrote:
>>>>> On 06.06.2017 16:34, Peter Maydell wrote:
>>>>>> On 6 June 2017 at 14:38, Kamil Rytarowski <n54@gmx.com> wrote:
>>>>>>> I've linked qemu with the original patch and:
>>>>>>> ./configure --disable-linux-user --disable-system --static
>>>>>>>
>>>>>>> I got some warnings, I think they are originated from our libc an=
d are
>>>>>>> not related to qemu:
>>>>>>>   LINK    sparc64-bsd-user/qemu-sparc64
>>>>>>> /usr/lib/libc.a(initfini.o): warning: common of `__ps_strings'
>>>>>>> overridden by definition
>>>>>>> /usr/lib/crt0.o: warning: defined here
>>>>>>> /usr/lib/libc.a(_env.o): warning: multiple common of `environ'
>>>>>>> /usr/lib/crt0.o: warning: previous common is here
>>>>>>> /usr/lib/libc.a(getprogname.o): warning: common of `__progname'
>>>>>>> overridden by definition
>>>>>>> /usr/lib/crt0.o: warning: defined here
>>>>>>
>>>>>> Yes, I think I've seen those before on NetBSD -- they look
>>>>>> like a bug in your libc to me, it shouldn't be confusing itself
>>>>>> with itself like that :-)
>>>>>>
>>>>>> thanks
>>>>>> -- PMM
>>>>>>
>>>>>
>>>>> I have filed this bug upstream: http://gnats.netbsd.org/52278
>>>>>
>>>>>
>>>>
>>>>
>>>> What's the status with this patch?
>>>>
>>>> NetBSD build still breaks due to ivshmem-*.
>>>
>>> I guess Michael expects a v4 that doesn't break the static build.
>>>
>>
>> -static works for me, I have restricted options to test build on !NetB=
SD
>> systems.
>>
>> Was this patch ok?
>>
>> diff --git a/Makefile b/Makefile
>> index c830d7a..2ef5a78 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -469,10 +469,12 @@ ifneq ($(EXESUF),)
>>  qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
>>  endif
>>
>> +ifdef CONFIG_IVSHMEM
>>  ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
>>  	$(call LINK, $^)
>>  ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
>>  	$(call LINK, $^)
>> +endif
>>
>>
>> So I could amend it.
>=20
> Please do.  Additionally consider
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f42f3df..ab70d01 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -203,7 +203,7 @@ gcov-files-pci-y +=3D hw/display/virtio-gpu-pci.c
>  gcov-files-pci-$(CONFIG_VIRTIO_VGA) +=3D hw/display/virtio-vga.c
>  check-qtest-pci-y +=3D tests/intel-hda-test$(EXESUF)
>  gcov-files-pci-y +=3D hw/audio/intel-hda.c hw/audio/hda-codec.c
> -check-qtest-pci-$(CONFIG_EVENTFD) +=3D tests/ivshmem-test$(EXESUF)
> +check-qtest-pci-$(CONFIG_IVSHMEM) +=3D tests/ivshmem-test$(EXESUF)
>  gcov-files-pci-y +=3D hw/misc/ivshmem.c
> =20
>  check-qtest-i386-y =3D tests/endianness-test$(EXESUF)
>=20

Thank you, I will give it a try.


--tFfVUIvqtEmwTTfVC0vaqKNFMs9aGkpen
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZR7AtAAoJEEuzCOmwLnZsh3gP/RpYGur94Ij0C3YbVuTMsFyB
bZCadfgin933xnHgaHSzo1N0niO+TqF8F479aV03SdK9MVspogXRkezMIJx9yJGj
m6SAU4l63a7cV1++6JPJvTUsNs01PjcjA+2wax0SzfEX6BfMmgjNMuzEo7AqWOnD
+qtewj5UShuoH4JFHa0vSFE0tFwHLYQsbbKfMRlHT8QZeGGQc6LjlyMbbpVBO69j
23qBR0Uk9/IgHcx83gZO8KWvnGFgS95ZynvDMDhci/ZSVcNU44JdqnrtkHPVqgWu
EaZydcRSh5IoIYZaec2bmywsN6OgQ+qztOVkDMkD/mXykrHZWXzsCHouOCU8I4xD
khkCTPXq1Yuu9z8QCqggSt8xzSEUsJHN2f21TXkwYIo1Sjur2GWspIgIUmVSe/04
dr7RyPzmhPPrlCwuL0g45MeeV93ss0svkZ2qYF4rKmc5Hxwht4Qa41fI7FHCZhkr
gNWO/I5OinKGH5s0seYdKgCuF6zwls5gkDk9u6dKsFRuhJlB60jABOZe7uiWZ/rh
tPwaerAs3VoM+4YqgUm4S6qA27ciJseUCMRRe9GQotuwUf3PY2sn8Bv0JgwJY79V
DkuZLSJiom+PwrfN1pXrqHLmy4biaA6zcKr9ofl/lgHDPEWjZnpSY9FvkXq50/Py
tOyeQRcCv56g9X6QbHz2
=ekeu
-----END PGP SIGNATURE-----

--tFfVUIvqtEmwTTfVC0vaqKNFMs9aGkpen--
